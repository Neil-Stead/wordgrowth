# convert_encoding.py
with open("media.csv", "r", encoding="gbk", errors="ignore") as infile:
    content = infile.read()

with open("media_utf8.csv", "w", encoding="utf-8") as outfile:
    outfile.write(content)
