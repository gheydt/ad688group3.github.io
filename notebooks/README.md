# Notebooks

Analysis notebooks for the AD688 Group 3 project.

## Data

The raw dataset (`MET_CareerCompass_2026`: 17 Parquet files, Lightcast schema, ~264 MB) is
**not** committed. Excluding it is a course instruction, not our own choice:

- Module 3 Lab 1: "Add large dataset files (e.g., `MET_CareerCompass_2026`) to `.gitignore`
  to prevent pushing them to GitHub. Make sure to add the file in gitignore first and then
  commit and sync."
- Module 3 Lab 2: "Exclude raw data (`MET_CareerCompass_2026`) using `.gitignore`"
- Module 1 Project: "Do not commit very large raw files if they are not needed on the public site."
- Module 3 Project: "Ensure `.gitignore` Excludes Large Files"

(A hard GitHub limit also applies: single files over 100MB are rejected, so a push would fail
regardless.)

The data is shared through Google Drive, not git. Everyone - and the EC2 instance - pulls the
same copy with `gdown` (source: Module 3 Lab 2):

```bash
gdown --folder "https://drive.google.com/drive/folders/11uTPfwHiRohl2ljSYeFuo0KKBUP_1vk4?usp=sharing" -O data/MET_CareerCompass_2026
```

The notebooks read it from `data/MET_CareerCompass_2026/` and verify the row count against
`data/MET_CareerCompass_2026/manifest.json` before running.

## Notebooks

- `step2_pyspark_filter_insurance.ipynb` - Step 2 (Module 2). Filters the postings to NAICS 5241
  (Insurance Carriers), and exports the handoff file for the cleaning + baseline step:
  - `../outputs/step2/insurance_5241_all_postings.xlsx`
  - `../outputs/step2/insurance_5241_all_postings.csv`

Runs on PySpark, matching the graded AWS EC2 environment per the syllabus.
