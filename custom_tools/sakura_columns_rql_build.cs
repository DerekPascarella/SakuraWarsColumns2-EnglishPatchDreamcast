// Written by esperknight

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace sakura_columns_rql_build
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
            string indir = args[0];
            

            BinaryReader hdr = new BinaryReader(File.OpenRead(indir + "\\_HDR_"));

            uint numBlocks = hdr.ReadUInt32();
            uint numFiles = hdr.ReadUInt32();
            string copyright = Encoding.GetEncoding("SJIS").GetString(hdr.ReadBytes(24));

            List<Entry> entries = new List<Entry>();
            for (int i = 0; i < numFiles; i++)
            {
                entries.Add(new Entry()
                {
                    filename = Encoding.GetEncoding("SJIS").GetString(hdr.ReadBytes(20)).Replace("\0", ""),
                    pos = (hdr.ReadUInt32() + numBlocks) * 0x800,
                    size = hdr.ReadUInt32() * 0x800,
                    unk1 = hdr.ReadUInt32()
                });
            }

            if (File.Exists(indir.Replace("_", ".")))
                File.Delete(indir.Replace("_", "."));

            BinaryWriter rql = new BinaryWriter(File.OpenWrite(indir.Replace("_", ".")));

            hdr.BaseStream.Seek(0, SeekOrigin.Begin);
            rql.Write(hdr.ReadBytes((int)hdr.BaseStream.Length));
            hdr.Close();

            List<string> filenames = entries.Select(x => x.filename).ToList();

            entries = entries.OrderBy(x => x.pos).ToList();
            for(int i = 0; i < entries.Count; i++)
            {
                Entry entry = entries[i];
                entry.pos = (uint)(rql.BaseStream.Position / 0x800) - numBlocks;

                long startPos = rql.BaseStream.Position;

                BinaryReader infile = new BinaryReader(File.OpenRead(indir + "\\" + entry.filename));

                string type = Encoding.GetEncoding("SJIS").GetString(infile.ReadBytes(4));
                infile.BaseStream.Seek(0, SeekOrigin.Begin);

                uint size = (uint)infile.BaseStream.Length;
                if (type != "TEN2")
                {
                    rql.Write(Encoding.GetEncoding("SJIS").GetBytes("TEND"));
                    rql.Write((uint)size);
                    for (int j = 0; j < 24; j++)
                    {
                        rql.Write((byte)0);
                    }

                    size += 32;
                }
                entry.size = (uint)((size / 0x800) + ((size % 0x800 > 0) ? 1 : 0));

                rql.Write(infile.ReadBytes((int)infile.BaseStream.Length));

                uint padding = 0x800 - (size % 0x800);
                for(int j = 0; j < padding; j++)
                {
                    rql.Write((byte)0);
                }

                entries[i] = entry;
            }

            entries = entries.OrderBy(x => x.filename).ToList();
            rql.BaseStream.Seek(32, SeekOrigin.Begin);
            for (int i = 0; i < numFiles; i++)
            {
                Entry entry = entries.Where(x => x.filename == filenames[i]).FirstOrDefault();

                rql.BaseStream.Seek(20, SeekOrigin.Current);
                rql.Write(entry.pos);
                rql.Write(entry.size);
                rql.Write(entry.unk1);
            }

            rql.Close();
        }
    }
}
