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

```
bin/jaypt CVE-2021-45058
```
