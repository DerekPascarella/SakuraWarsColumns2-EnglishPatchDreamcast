// Written by esperknight

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sakura_columns_rql_extract
{
    class Entry
    {
        public string filename;
        public uint pos;
        public uint size;
        public uint unk1;
    }

    class Program
    {
        static void Main(string[] args)
        {
            string filename = args[0];

            BinaryReader bin = new BinaryReader(File.OpenRead(filename));

            uint numBlocks = bin.ReadUInt32();
            uint numFiles = bin.ReadUInt32();
            string copyright = Encoding.GetEncoding("SJIS").GetString(bin.ReadBytes(24));

            List<Entry> entries = new List<Entry>();
            for(int i = 0;  i < numFiles; i++)
            {
                entries.Add(new Entry()
                {
                    filename = Encoding.GetEncoding("SJIS").GetString(bin.ReadBytes(20)).Replace("\0", ""),
                    pos = (bin.ReadUInt32() + numBlocks) * 0x800,
                    size = bin.ReadUInt32() * 0x800,
                    unk1 = bin.ReadUInt32()
                });
            }

            string dir = filename.Replace(".", "_");
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            foreach(Entry entry in entries)
            {
                bin.BaseStream.Seek(entry.pos, SeekOrigin.Begin);
                string type = Encoding.GetEncoding("SJIS").GetString(bin.ReadBytes(4));
                uint size = 0;
                if (type == "TEND")
                {
                    size = bin.ReadUInt32();
                    bin.BaseStream.Seek(24, SeekOrigin.Current);
                }
                else if (type == "TEN2")
                {
                    size = bin.ReadUInt32() + 12;
                    bin.BaseStream.Seek(entry.pos, SeekOrigin.Begin);
                }
                else
                {
                    throw new Exception("Unknown type!");
                    Console.ReadKey();
                }

                if (File.Exists(dir + "\\" + entry.filename))
                    File.Delete(dir + "\\" + entry.filename);

                File.WriteAllBytes(dir + "\\" + entry.filename, bin.ReadBytes((int)size));
            }

            bin.BaseStream.Seek(0, SeekOrigin.Begin);
            File.WriteAllBytes(dir + "\\" + "_HDR_", bin.ReadBytes((int)numBlocks * 0x800));

            bin.Close();
        }
    }
}
