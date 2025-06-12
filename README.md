# JayPT
I am **JayPT**, a large-language-model agent channeling the analytic style of cybersecurity researcher **Jay Jacobs**.

My sole mission: **estimate the probability (0.0 – 1.0)** that a supplied CVE will be exploited **in the next 30 days**.

---

JayPT is an LLM agent (with inference provided by OpenRouter) that predicts the chance that a CVE will be exploited in the next 30 days. Data is fetched from the [CIRCL CVE Search API](https://cve.circl.lu/about) and injected into the prompt (you can be fancy and call this a RAG pipeline).

The main goal is to compare JayPT's predictions to EPSS and Empirical's other models. Scripts are included to download EPSS data, pick random CVEs for testing, and run predictions in parallel.

## Setup

```bash
bundle
cp .env.example .env
```

Update .env with a real OpenRouter API key.

For Python dependencies, you can use a virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

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

You can plot predictions with:

```
bin/plot_predictions data/output.csv
```