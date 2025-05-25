

# 🏠 Real Estate Data Analysis & Azure Pipeline Project 


[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
`<!-- Placeholder: Replace with actual license if different -->`{=html}
[![Build
Status](https://img.shields.io/badge/Build-Passing-brightgreen)](https://example.com)
`<!-- Placeholder: Replace with actual build status link -->`{=html}


## 🔍 Executive Summary {#-executive-summary}


This project implements an end-to-end data analysis pipeline for real
estate data, leveraging Microsoft Azure cloud services. It covers data
ingestion from local sources to Azure SQL Database, data modeling using
SSMS, transformation via Azure Data Factory dataflows, automated machine
learning model training with Azure ML, and interactive visualization
using Power BI. The goal is to extract actionable insights from real
estate data through a robust and scalable cloud-based workflow.


------------------------------------------------------------------------

## 📖 Table of Contents {#-table-of-contents}

1.  [Project Objectives](#-project-objectives)
2.  [Workflow Overview](#-workflow-overview)
3.  [Dataset Overview](#-dataset-overview)
4.  [Technologies & Tools](#-technologies--tools)
5.  [Project Structure](#-project-structure)
6.  [Setup Guide](#-setup-guide)
7.  [Usage Instructions](#-usage-instructions)
8.  [Team Roles](#-team-roles)
9.  [Support & Contact](#-support--contact)
10. [License](#-license)


------------------------------------------------------------------------

## 🏆 Project Objectives {#-project-objectives}

-   **Establish a Cloud-Based Data Pipeline:** Implement a full data
    workflow using Azure services (SQL DB, ADF, ML).
-   **Data Ingestion & Modeling:** Securely upload local data to Azure
    SQL DB and define relationships using SSMS.
-   **Data Transformation:** Clean, filter, and transform data using
    Azure Data Factory dataflows to create analysis-ready datasets.
-   **Predictive Modeling:** Utilize Azure Automated ML to build and
    evaluate machine learning models based on the processed data.
-   **Interactive Visualization:** Develop a Power BI dashboard
    connected to Azure SQL DB for insightful data exploration and
    reporting.
-   **Provide Actionable Insights:** Deliver data-driven findings
    relevant to the real estate domain.
:::


------------------------------------------------------------------------

## 🔄 Workflow Overview {#-workflow-overview}
:::

The project follows these key steps:

1.  **Infrastructure Setup:** Provision Azure Server and Azure SQL
    Database.
2.  **Data Ingestion:** Upload local data to Azure SQL DB via a Python
    script.
3.  **Database Modeling (SSMS):** Design ERD and establish table
    relationships.
4.  **Data Transformation (Azure Data Factory):**
    -   Ingest data from Azure SQL DB.
    -   Apply filters and transformations using ADF Dataflows.
    -   Generate a new, processed table.
5.  **Store Processed Data:** Save the transformed table back to Azure
    SQL Database.
6.  **Machine Learning (Azure ML):**
    -   Connect Azure ML to the processed data in Azure SQL DB.
    -   Configure and run an Automated ML pipeline.
7.  **Data Visualization (Power BI):**
    -   Connect Power BI to the data in Azure SQL DB.
    -   Create an interactive dashboard.

    ![Our Team](workflow.jpg)


------------------------------------------------------------------------

## 📁 Dataset Overview {#-dataset-overview}

-   **Source**: Primarily local CSV files (Agents, Clients, Properties,
    Sales, Visits) ingested into Azure SQL DB.
-   **Domain**: Real Estate
-   **Primary Attributes** (Examples - adapt based on actual data):
    -   Property Details: Location, size, price, type
    -   Sales Data: Transaction dates, prices, agent involved
    -   Client/Agent Info: Contact details, interactions
    -   Visit Data: Property visit logs, dates, feedback
:::


------------------------------------------------------------------------

## 🛠 Technologies & Tools {#-technologies--tools}

  -----------------------------------------------------------------------
  Functionality         Tools
  --------------------- -------------------------------------------------
  **Cloud Platform**    Microsoft Azure

  **Database**          Azure SQL Database, SQL Server Management Studio
                        (SSMS)

  **Data Integration &  Azure Data Factory (Dataflows)
  ETL**                 

  **Machine Learning**  Azure Machine Learning (Automated ML), Python
                        (Scikit-learn, Pandas)

  **Business            Power BI
  Intelligence**        

  **Scripting & Data    Python (Pandas, Pyodbc or similar)
  Handling**            

  **Version Control**   Git, GitHub
  -----------------------------------------------------------------------
:::

::: {#64488a74 .cell .markdown}

------------------------------------------------------------------------
:::

::: {#fbe330dd .cell .markdown}
## 🏗️ Project Structure {#️-project-structure}
:::

::: {#1ec4d6d9 .cell .markdown}
The repository is organized as follows:
:::

::: {#e311d0af .cell .markdown}
    ├── config/               # Configuration files (e.g., config.json)
    ├── data/
    │   └── raw/              # Original raw input data (CSV files)
    ├── docs/                 # Documentation (presentation.pdf, info.txt, etc.)
    ├── models/               # Trained ML models (model.pkl, MLmodel artifacts)
    ├── reports/
    │   ├── dashboards/       # Power BI dashboards (dashboard.pbix)
    │   ├── figures/          # Images and diagrams (ERD.jpg, ML pipeline.jpg)
    │   └── performance/      # Model performance data (TSV files)
    ├── src/
    │   ├── dataflow/         # Azure Data Factory related scripts/configs/exports
    │   ├── sql/              # SQL scripts (ERD.sql, table queries)
    │   └── import.py         # Python script for data ingestion to Azure SQL DB
    ├── .gitignore            # Specifies intentionally untracked files
    ├── conda.yaml            # Conda environment file (if used)
    ├── python_env.yaml       # Python environment file (if used)
    ├── requirements.txt      # Pip requirements file
    └── README.md             # This file
:::

::: {#7b3e8ece .cell .markdown}

------------------------------------------------------------------------
:::

::: {#51af7ff5 .cell .markdown}
## 🚀 Setup Guide {#-setup-guide}
:::

::: {#cf0089c1 .cell .markdown}
1.  **Clone the Repository:**
    `bash     git clone <your-repository-url>     cd <repository-name>`
2.  **Azure Setup:**
    -   Ensure you have an active Azure subscription.
    -   Provision the necessary resources: Azure SQL Database, Azure
        Data Factory, Azure Machine Learning workspace.
    -   Configure firewall rules and access permissions as needed.
3.  **Configuration:**
    -   Update connection strings and other parameters in
        `config/config.json` and relevant scripts (`src/import.py`, ADF
        linked services, etc.) to match your Azure environment.
4.  **Environment Setup:**
    -   Install required Python packages:
        `bash     pip install -r requirements.txt`
    -   (Optional) If using Conda, create the environment:
        `bash     # conda env create -f conda.yaml     # conda activate <env-name>`
:::

::: {#7152ae51 .cell .markdown}

------------------------------------------------------------------------
:::

::: {#a27e124a .cell .markdown}
## ▶️ Usage Instructions {#️-usage-instructions}
:::

::: {#e274e99d .cell .markdown}
-   **Data Ingestion:** Run the Python script to upload data to Azure
    SQL DB: `bash     python src/import.py`
-   **Data Transformation:** Trigger the appropriate pipeline/dataflow
    within your Azure Data Factory instance.
-   **Machine Learning:** Navigate to your Azure ML workspace, locate
    the Automated ML experiment/pipeline, and run it.
-   **Visualization:** Open the `dashboard.pbix` file located in
    `reports/dashboards/` using Power BI Desktop. Refresh the data
    connection to point to your Azure SQL Database.
:::

::: {#3276590f .cell .markdown}

------------------------------------------------------------------------
:::

::: {#48d39e30 .cell .markdown}
## 👥 Team Roles {#-team-roles}
:::

::: {#d44deed9 .cell .markdown}
Please fill in the roles, responsibilities, and LinkedIn profiles for
each team member below:

  
| Name           | Role                      | Responsibilities                                              | LinkedIn Profile |
| :------------- | :------------------------ | :------------------------------------------------------------ | :--------------- |
| Sayed Elmasry  | Azure & ML Engineer       | Azure Infrastructure Setup, Machine Learning Implementation and Deployment | [Sayed Elmasry](https://www.linkedin.com/in/sayed-elmasry) |
| Verina Fouad   | SQL & Power BI Developer  | SQL Development, Power BI Dashboard Design and Theming        | [Verina Fouad](https://www.linkedin.com/in/verina-fouad-06270217a?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app) |
| Mai Mamdooh    | Power BI Analyst/Developer | Power BI Analysis, Dashboard Creation, Presentations          | [Mai Mamdooh](https://www.linkedin.com/in/mai-mamdooh?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app) |
| Naira ELazab   | SQL Analyst               | Writing and optimizing SQL queries, Data Analysis, Presentations | [Naira ELazab](https://www.linkedin.com/in/naira-elazab/) |
| Rewan Gamal    | Power BI Analyst          | Power BI Data Modeling, Visualization, and Analysis            | [Rewan Gamal](https://www.linkedin.com/in/rewan-gamal-870964192?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app) |
| Zaineb Elghoul | SQL Developer             | SQL Scripting, Query Optimization, Data Preparation            | [Zaineb Elghoul](https://www.linkedin.com/in/zaineb-elghoul-3711a7173?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app) |
| Nermin Reda    | Documentation Specialist  | Project Documentation, Reporting, and Workflow Tracking        | [Nermin Reda](https://www.linkedin.com/in/nermin-reda-97798524a/) |


------------------------------------------------------------------------


## 📞 Support & Contact {#-support--contact}


For questions, issues, or suggestions regarding this project, please use
the following channels:

-   **Primary Contact:** \[Your Name / Lead Name\] -
    \[<your.email@example.com>\]
-   **Issue Tracker:** \[Link to GitHub Issues for the repository\]
-   **Project Channel:** \[Link to relevant Slack/Teams channel, if
    applicable\]

*(Please update contact details and links)*


------------------------------------------------------------------------


## 📜 License {#-license}

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)]()
[![Build
Status](https://img.shields.io/badge/Build-Passing-brightgreen)]()

This project is licensed under the MIT License. See the `LICENSE` file
for details. (Ensure a LICENSE file exists or specify the license
directly).


------------------------------------------------------------------------
