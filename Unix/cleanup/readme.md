# Cleanup

## organize.sh

Sorts the files in your **Desktop** and **Downloads** folders into folders by type.
Works on macOS and Linux, needs only `bash` and `curl`, and nothing has to be cloned
or installed.

### Run it without cloning

Always preview first. `--dry-run` prints what would happen and changes nothing:

```bash
curl -fsSL https://raw.githubusercontent.com/VivekBhat/bash_scripts/main/Unix/cleanup/organize.sh | bash -s -- --dry-run
```

If the preview looks right, run it for real:

```bash
curl -fsSL https://raw.githubusercontent.com/VivekBhat/bash_scripts/main/Unix/cleanup/organize.sh | bash
```

Use the `raw.githubusercontent.com` link above, not the
[GitHub page link](https://github.com/VivekBhat/bash_scripts/blob/main/Unix/cleanup/organize.sh).
The page link returns HTML, which `bash` cannot run.

Options go after `bash -s --`:

| Option | What it does |
| --- | --- |
| `-n`, `--dry-run` | Show what would happen, change nothing |
| `--home DIR` | Organize `DIR/Desktop` and `DIR/Downloads` instead of your home folder |
| `--no-desktop` | Skip the Desktop folder |
| `--no-downloads` | Skip the Downloads folder |
| `-h`, `--help` | Show help |

Example, Downloads only:

```bash
curl -fsSL https://raw.githubusercontent.com/VivekBhat/bash_scripts/main/Unix/cleanup/organize.sh | bash -s -- --no-desktop
```

### Prefer to read it first?

Piping a script from the internet straight into `bash` runs it immediately. To check it
before running:

```bash
curl -fsSL -o organize.sh https://raw.githubusercontent.com/VivekBhat/bash_scripts/main/Unix/cleanup/organize.sh
less organize.sh
bash organize.sh --dry-run
bash organize.sh
```

### What it does

Only files directly inside Desktop and Downloads are touched. Sub-folders, hidden files
and files without an extension are left alone.

| File types | Downloads goes to | Desktop goes to |
| --- | --- | --- |
| jpg, jpeg, png, gif, heic, webp, svg, bmp, tiff | `Downloads/Images` | `Desktop/Misc/Images` |
| pdf | `Downloads/Pdfs` | `Desktop/Misc/Pdfs` |
| doc, docx, txt, csv, xls, xlsx, ppt, pptx, rtf, md, pages, numbers, key | `Downloads/Documents` | `Desktop/Misc/Documents` |
| zip, tar, gz, tgz, rar, 7z | `Downloads/Zips` | `Desktop/Misc/Zips` |
| xml, json, yaml, yml, properties, toml, ini | `Downloads/Configs` | `Desktop/Misc/Configs` |
| mov, mp4, m4v, avi, mkv | `Downloads/Videos` | `Desktop/Misc/Videos` |
| mp3, wav, m4a, aac, flac | `Downloads/Audio` | `Desktop/Misc/Audio` |
| ics, dmg, pkg, msi, exe, html, htm, lnk | Trash | Trash |

Extensions match in any case (`.PNG` and `.png` are the same).

### Safety

- Nothing is deleted. Unwanted files go to the Trash (`~/.Trash` on macOS,
  `~/.local/share/Trash/files` on Linux), so you can get them back.
- Nothing is overwritten. If `Report.pdf` already exists in the target folder, the new
  file becomes `Report (1).pdf`.
- It never asks questions, so it cannot hang when piped.
- All code runs from the last line, so a download cut off halfway does nothing.
- Running it again is harmless: already sorted files are not moved.

## cleanup.sh

The older version, used by the MBP15 profile. It deletes some file types permanently
(`rm -rf`), so prefer `organize.sh`, especially for anyone else.
