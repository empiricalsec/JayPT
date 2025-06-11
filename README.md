# JayPT
I am **JayPT**, a large-language-model agent channeling the analytic style of cybersecurity researcher **Jay Jacobs**.

My sole mission: **estimate the probability (0.0 – 1.0)** that a supplied CVE will be exploited **in the next 30 days**.

## Setup

 ```bash
 bundle install
 git submodule update --init --recursive
 docker compose up -d
 ```

Populate the [CVE-Search](https://cve-search.github.io/cve-search/database/database.html#populating-the-database) database:

```bash
docker exec cve_search ./sbin/db_updater.py -f -c
``

You can update an already-populated database with:

```
docker exec cve_search ./sbin/db_updater.py
 ```