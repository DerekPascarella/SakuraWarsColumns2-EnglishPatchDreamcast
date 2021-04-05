# -*- coding: utf-8 -*-
"""
Created on Mon Mar 15 19:09:04 2021

@author: nanashi
"""

class symbol_table:

    def __init__(self):
        '''
        Contains the symbol table for the decompression. Symbols can recursive
        to a maxium depth of 256.

        Returns
        -------
        None.

        '''
        self._symbol_lut = bytearray(256)
        self._data = bytearray(256)
        
        for i in range(0,256):
            self._symbol_lut[i] = i
            
    def add(self, symbol, data):
        """
        Adds a symbol to the symbol table

        Parameters
        ----------
        symbol : int
            symbol byte.
        data : (int,int)
            symbol data tuple.

        Returns
        -------
        rtn : int
            Number of bytes read (min: 1, max: 2).

        """
        rtn = 1
        self._symbol_lut[symbol] = data[0]
        if symbol != data[0]:
            rtn += 1
            self._data[symbol] = data[1]
        return rtn
        
    def get(self, symbol):
        """
        Get symbol data

        Parameters
        ----------
        symbol : int
            symbol byte.

        Returns
        -------
        int
            data byte 1.
        int
            data byte 2.

        """
        return self._data[symbol], self._symbol_lut[symbol]
    
    def is_symbol(self, symbol):
        """
        Returns True if symbol is in the table

        Parameters
        ----------
        symbol : int
            symbol byte.

        Returns
        -------
        bool

        """
        return not (symbol == self._symbol_lut[symbol])
    
def decompress(file):
    
    decompressed = bytearray(4194304)                                           # decompression buffer 4 mb
    write_stack = []
    
    with open(file, 'rb') as ifile:
        delimiter = ifile.read(4)
        if delimiter != "TEN2".encode("ascii"):                                 # check delimiter
            return -1
        dlen = int.from_bytes(ifile.read(4), "little")                          # read decoded length
        ifile.read(4)                                                           # don't know what those do
        compressed = ifile.read()

    ipos = 0
    opos = 0
    if dlen == 0:
        return -1
    
    while True:
        sym_table = symbol_table()                                              # build new symbol table
        symbol_offset = compressed[ipos]
        ipos += 1
        symbol = 0
        while True:
            if symbol_offset > 127:
                symbol_offset -= 127
                symbol += symbol_offset
                symbol_offset = 0
                
            if symbol == 256:
                break
            
            cntr = 0
            if symbol_offset >= 0:
                while True:
                    symbol_data = (compressed[ipos], compressed[ipos+1])
                    ipos += sym_table.add(symbol, symbol_data)
                    cntr += 1
                    symbol += 1
                    if cntr > symbol_offset:
                        break
                    
            if symbol == 256:
                break
                  
            symbol_offset = compressed[ipos]
            ipos += 1
            
        chunk_size = int().from_bytes(compressed[ipos:ipos+2], "big")      
        ipos += 2
            
        while True:

            if len(write_stack) == 0:                                           # check if the stack is empty
                
                if chunk_size == 0:                                             # check if end of chunk is reached
                    chunk_size -= 1
                    if ipos >= dlen:
                        return decompressed[:opos]
                    else:
                        break
                else:                                                           # get another byte from the encoded stream             
                    chunk_size -= 1
                    dec_byte = compressed[ipos]
                    ipos += 1
            
            else:                                                               # pop byte from stack
                 dec_byte = write_stack.pop(-1)
                 
            '''
            Check if the decoded byte is a symbol
            
            '''   
            if sym_table.is_symbol(dec_byte):                
                symbol_data = sym_table.get(dec_byte)                
                write_stack.append(symbol_data[0])
                write_stack.append(symbol_data[1])
                
            else:
                decompressed[opos] = dec_byte
                opos += 1