import os
import subprocess

root = "phd_testset"
for f in os.listdir(root):
    base, ext = os.path.splitext(f)
    if ext != ".mxl":
        continue
    print(f, "- midi")
    subprocess.run([f"/mnt/c/Program Files/MuseScore 3/bin/MuseScore3.exe", f"{root}/{f}", "-o", f"{root}/{base}.mid"])
    print(f, "- musicxml")
    subprocess.run([f"/mnt/c/Program Files/MuseScore 3/bin/MuseScore3.exe", f"{root}/{base}.mid", "-o", f"{root}/{base}.musicxml"])
