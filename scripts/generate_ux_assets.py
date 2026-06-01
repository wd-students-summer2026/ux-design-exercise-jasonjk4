import subprocess
from pathlib import Path
import os


ROOT = Path(__file__).resolve().parents[1]
SWIFT_SCRIPT = ROOT / "scripts" / "generate_ux_assets.swift"
CACHE_DIR = ROOT / ".swift-cache"


def main():
    CACHE_DIR.mkdir(exist_ok=True)
    env = os.environ.copy()
    env["CLANG_MODULE_CACHE_PATH"] = str(CACHE_DIR)
    env["SWIFT_MODULE_CACHE_PATH"] = str(CACHE_DIR)
    subprocess.run(["swift", str(SWIFT_SCRIPT)], cwd=ROOT, check=True, env=env)


if __name__ == "__main__":
    main()
