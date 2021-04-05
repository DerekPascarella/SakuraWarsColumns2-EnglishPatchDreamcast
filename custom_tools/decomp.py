# -*- coding: utf-8 -*-
"""
Created on Fri Mar 19 17:27:43 2021

@author: nanashi
"""

import sys

from dc_swc_decomp import decompress

with open(sys.argv[1], "rb") as ifile:
    decompressed = bytes(decompress(sys.argv[1]))
    ref = ifile.read()
    
with open(sys.argv[1], "wb") as ofile:    
    ofile.write(decompressed)
    
print("Success")