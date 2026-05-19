#!/usr/bin/env python3
import json
import pathlib

src = pathlib.Path("~/.config/sway/keybinds.json").expanduser()
out = pathlib.Path("~/.config/sway/keybinds.conf").expanduser()

data = json.loads(src.read_text())
lines = ["# generated from keybinds.json — do not edit directly"]

for section, binds in data.items():
    lines.append(f"\n# {section}")
    for b in binds:
        locked = "--locked " if b.get("locked") else ""
        no_repeat = "--no-repeat " if b.get("no_repeat") else ""
        lines.append(f"bindsym {locked}{no_repeat}{b['key']} {b['action']}")

out.write_text("\n".join(lines) + "\n")
print(f"wrote {out}")
