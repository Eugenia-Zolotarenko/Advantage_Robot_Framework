# Advantage Online Shopping — Robot Framework Test Automation

Automated test suite for [Advantage Online Shopping](http://www.advantageonlineshopping.com) — a demo e-commerce application by OpenText. Built with the **Keyword Driven Testing** approach using Robot Framework.

---

## Test Scenarios

**Scenario 1 — New User Purchase Flow**
Registration → Login → Select product → Add to cart → Checkout with SafePay → Sign out

Implemented in two ways:
- `Purchase_Flow_New_User_From_File.robot` — DataDriver reads product combinations from `Data/register_flow_data.csv`
- `Purchase_Flow_New_User_From_List.robot` — parameterized with Test Template and list variables from `Data/Data_Keywords.robot`

**Scenario 2 — Existing User Purchase Flow (3 products)**
Login → Select 3 products → Add to cart → Verify cart contents → Checkout with SafePay → Sign out

Implemented in two ways:
- `Purchase_Flow_Three_Products_From_File.robot` — DataDriver reads product combinations from `Data/purchase_flow_data.csv`
- `Purchase_Flow_Three_Products_From_List.robot` — uses list variables from `Data/Data_Keywords.robot` (demonstrates manual test-case approach without DataDriver)

Additional test suites cover: sign-in (positive and negative), account menu, product selection, cart verification, and checkout steps.

---

## Requirements

- Python 3.x
- Google Chrome / Firefox / Microsoft Edge
- Corresponding WebDriver (managed automatically by Selenium)

### Python packages

Defined in `requirements.txt`:

| Package | Version |
|---|---|
| robotframework | 7.5.1 |
| robotframework-seleniumlibrary | 6.9.0 |
| robotframework-datadriver | 1.11.2 |

---

## Installation

```bash
# 1. Clone the repository
git clone https://github.com/Eugenia-Zolotarenko/Advantage_Robot_Framework
cd AdvantageProject

# 2. Create and activate virtual environment
python -m venv .venv
.venv\Scripts\activate

# 3. Install dependencies
pip install -r requirements.txt
```

---

## Running Tests

### Run main purchase flow (DataDriver, all CSV rows)
```bash
robot -d Output\ --randomize tests TestCases\Purchase_Flow_Three_Products_From_File.robot
```

### Run all test suites
```bash
robot -d Output\ --randomize tests TestCases\
```

### Run with a specific browser
```bash
robot -d Output\ --randomize tests -v BROWSER:firefox TestCases\
```
Supported values: `chrome`, `firefox`, `edge`, `headlesschrome`, `headlessfirefox`

### Run only negative login tests
```bash
robot -d Output\ --randomize tests --include negative TestCases\Sign_In.robot
```

---

## Project Structure

```
AdvantageProject/
├── TestCases/                  # Test suites (business-level keywords only)
│   ├── Purchase_Flow_Three_Products_From_File.robot   # Scenario 2 — DataDriver-based
│   ├── Purchase_Flow_Three_Products_From_List.robot   # Scenario 2 — list variables
│   ├── Purchase_Flow_New_User_From_File.robot   # Scenario 1 — DataDriver-based
│   ├── Purchase_Flow_New_User_From_List.robot  # Scenario 1 — list variables
│   ├── Sign_In.robot                        # Login tests (positive + negative)
│   ├── Registration.robot
│   ├── Cart.robot
│   ├── Checout.robot
│   └── ...
│
├── Resources/                  # Keyword libraries (technical implementation)
│   ├── Base_Keywords.robot
│   ├── Product_Keywords.robot
│   ├── Cart_Keywords.robot
│   ├── Checkout_Keywords.robot
│   ├── Purchase_Flow_Keywords.robot
│   ├── Sign_In_Keywords.robot
│   ├── Sign_Out_Keywords.robot
│   ├── Register_New_User_Keywords.robot
│   ├── Auth_Keywords.robot
│   ├── Account_Menu_Keywords.robot
│   ├── Select_Product_Keywords.robot
│   ├── Locators.robot          # All UI locators
│   └── Variables.robot         # Configuration variables
│
├── Data/                       # Test data
│   ├── purchase_flow_data.csv  # Product combinations for Scenario 2
│   ├── register_flow_data.csv  # Product combinations for Scenario 1
│   ├── account_menu_items.csv  # Expected account menu items
│   └── Data_Keywords.robot     # Test data keywords (users, shipping addresses)
│
├── docs/                       # Keyword documentation (HTML)
├── Output/                     # Test results (log.html, report.html)
└── Jenkinsfile                 # CI/CD pipeline definition
```

---

## Keyword Documentation

HTML documentation for all keyword libraries is generated with `libdoc` and available in the `docs/` folder.

To regenerate after changes:
```bash
for %f in (Resources\*_Keywords.robot) do .venv\Scripts\python.exe -m robot.libdoc "%f" "docs\%~nf.html"
```

Open any `docs\*_Keywords.html` file in a browser to browse the keyword reference.

---

## CI/CD — Jenkins

The project includes a `Jenkinsfile` with:
- **Setup** stage — creates `.venv` and installs dependencies from `requirements.txt`
- **Scheduled run** every day at 02:00
- **Browser selection** via build parameter
- **Purchase Flow** stage — runs `Purchase_Flow_Three_Products_From_File.robot`
- **Generate Keyword Docs** stage — regenerates HTML documentation
- **Robot Framework plugin** for test results with pass threshold 90%

All paths in the pipeline are relative to the workspace root, so the project runs on any machine without configuration changes.

### Jenkins prerequisites
- **Python 3.x** must be installed with **"Add Python to PATH"** checked during installation — this makes `python` available to the Jenkins service automatically
- **Jenkins** must be installed and running as a service
- A supported browser must be installed (Chrome, Firefox, or Edge); WebDriver is managed automatically by Selenium

> **Note:** If Python was installed without adding it to PATH, add `C:\PythonXXX` and `C:\PythonXXX\Scripts` to **System variables → Path** (not user variables), then restart the Jenkins service.

> **Note:** headless Edge is not supported in Jenkins due to profile path issues. Use `headlesschrome` or `headlessfirefox` for CI runs.

### Jenkins job setup
1. New Item → Pipeline
2. Under **Pipeline**: set Definition to `Pipeline script from SCM`
3. SCM: `Git`, Repository URL: `https://github.com/Eugenia-Zolotarenko/Advantage_Robot_Framework`
4. Script Path: `Jenkinsfile` (or `Jenkinsfile.register` for the registration flow pipeline)
5. Save → Build Now

---

## Test Data

Product combinations for the purchase flow are defined in `Data/purchase_flow_data.csv`.  
Each row follows the format: `category|position` or `category|position|quantity` (semicolon-separated for multiple products).

Example:
```
products_string
mice|1;speakers|2;headphones|1
tablets|1;laptops|2;mice|3
```
