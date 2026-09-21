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

The Step 2 notebook reads it from `data/MET_CareerCompass_2026/` and verifies the row count against
`data/MET_CareerCompass_2026/manifest.json` before running. Step 3 reads it too, but only to compare
the old numbers against the new ones.

### The Step 3 dataset (2024)

Step 3 uses a different file, from the Module 3 Project instructions: one Lightcast CSV of about
700 MB covering May to September 2024. Same rule applies, it is not committed and it never will be.

```bash
gdown 1V2GCHGt2dkFGqVBeoUFckU4IhUgk4ocQ -O data/Lightcast_JobPostings_2024_raw/lightcast_job_postings.csv
```

You do not have to run that by hand. The Step 3 notebook downloads the file itself if a full-size
copy is not already there, then checks it before trusting it: format read from the first bytes
rather than the file extension, size, and a real row count from a CSV parser. That last one matters,
because job descriptions contain line breaks inside quoted text, so counting lines gives about
13 million against 72,498 actual rows.

Once it passes, the notebook writes a verified Parquet copy to `data/Lightcast_JobPostings_2024/`.
Both that folder and the `_raw` one are gitignored.

## Notebooks

- `step2_pyspark_filter_insurance.ipynb` - Step 2 (Module 2). Filters the postings to NAICS 5241
  (Insurance Carriers), and exports the handoff file for the cleaning + baseline step:
  - `../outputs/step2/insurance_5241_all_postings.xlsx`
  - `../outputs/step2/insurance_5241_all_postings.csv`

- `step3_load_dataset.ipynb` - Step 3 (Module 3). Loads the 2024 dataset, checks it before trusting
  it, saves a verified Parquet copy, and compares the new data against the Step 2 data. Exports the
  same insurance panel in the same 34 columns as Step 2, so the two line up column for column:
  - `../outputs/step3/insurance_5241_all_postings_step3.csv`

  It also writes a data dictionary, an old versus new comparison, and a Step 2 against Step 3
  variance analysis. Those stay local for now and are not in this repo.

Runs on PySpark, matching the graded AWS EC2 environment per the syllabus.
