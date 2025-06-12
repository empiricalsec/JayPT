# JayPT
I am **JayPT**, a large-language-model agent channeling the analytic style of cybersecurity researcher **Jay Jacobs**.

My sole mission: **estimate the probability (0.0 – 1.0)** that a supplied CVE will be exploited **in the next 30 days**.

## Setup

```bash
bundle
cp .env.example .env
```

Update .env with a real OpenRouter API key.

## Usage

**Single CVE**:
This will run the models against a single CVE and print the results.

```
bin/jaypt CVE-2021-45058
```

**Batch CVEs**:
This will run the models against a batch of CVEs in an input file (argument 1) and save the results to a CSV file (argument 2).

```
bin/update_epss_data
bin/generate_sampling
bin/jaypt data/cve_sampling.csv data/output.csv
```

The input file should be a CSV with a column named "CVE ID".