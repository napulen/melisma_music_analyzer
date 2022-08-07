import subprocess
import os
import time

if __name__ == "__main__":
    log = open("execution_times.log", "w")
    root = "phd_testset_krn"
    for f in sorted(os.listdir(root)):
        print(f)
        base, ext = os.path.splitext(f)
        start = time.time()
        x = subprocess.run(
            f"docker run -it melisma {root}/{f}".split(),
            capture_output=True,
        )
        analyzed = f"{root}/{base}_annotated.krn"
        with open(analyzed, "w") as fd:
            fd.write(x.stdout.decode())
        end = time.time()
        log.write(f"{f}: {end - start:.2f}\n")
        log.flush()
    log.close()
