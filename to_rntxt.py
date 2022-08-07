import os

import music21

if __name__ == "__main__":
    root = "phd_testset_predictions"
    for f in os.listdir(root):
        base, ext = os.path.splitext(f)
        if ext != ".krn":
            continue
        print(f)
        # Some preprocessing
        with open(os.path.join(root, f)) as fd:
            data = fd.read()
            spines = len(data.split("\n", 1)[0].split("\t"))
            data = data.replace("**tsharm", "**harm")
            if spines == 3:
                staff = "*staff1\t*staff1\t*"
            elif spines == 4:
                staff = "*staff1\t*\t*staff1\t*"
            data = data.replace("**tsroot\n", f"**tsroot\n{staff}\n")
        try:
            s = music21.converter.parseData(data, format="humdrum")
            s.show("text")
            s.write(fmt="rntxt", fp=os.path.join(root, f"{base}.rntxt"))
        except music21.humdrum.spineParser.HumdrumException:
            continue
