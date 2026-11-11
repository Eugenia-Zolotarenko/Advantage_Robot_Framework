# Test Data

## purchase_flow_data.csv

Data-driven test file for the purchase flow with existing users. Each row is one test case.

### Columns

| Column | Description | Example |
|--------|-------------|---------|
| `*** Test Cases ***` | Test name shown in the report | `Buy Three Laptops` |
| `${products_string}` | Products to buy, separated by `;` | `mice\|1\|1;speakers\|7\|2` |
| `${username}` | Registered user account | `user10195449` |
| `${password}` | Account password | `secretpad0rD` |
| `${safepay_username}` | SafePay account username | `user_alice` |
| `${safepay_password}` | SafePay account password (4+ chars, lower, upper, number) | `AlicePay1` |
| `${first_name}` | Shipping: first name | `Alice` |
| `${last_name}` | Shipping: last name | `Johnson` |
| `${phone}` | Shipping: phone number | `+4316012345` |
| `${country}` | Shipping: country | `Austria` |
| `${city}` | Shipping: city | `Vienna` |
| `${address}` | Shipping: street address | `Mariahilfer Str 55` |
| `${postal_code}` | Shipping: postal code | `1060` |
| `${state}` | Shipping: state / region | `Wien` |
| `[Tags]` | Tag for filtering test runs | `smoke`, `quantity`, `models`, `mixed`, `control` |

### Tags

| Tag | Tests |
|-----|-------|
| `smoke` | 3 basic end-to-end scenarios |
| `mixed` | Different categories and quantities |
| `quantity` | Buy 3 items of the same product |
| `models` | Buy 3 different models from one category |
| `control` | Control scenarios |

---

## register_flow_data.csv

Data-driven test file for the registration flow. Each row registers a new unique user and completes a purchase. Username and email are generated automatically at runtime.

### Columns

| Column | Description | Example |
|--------|-------------|---------|
| `*** Test Cases ***` | Test name shown in the report | `Register And Buy One Tablet` |
| `${products_string}` | Products to buy, separated by `;` | `tablets\|2\|1` |
| `${password}` | Password used for registration and login | `secretpad0rD` |
| `${safepay_username}` | SafePay account username | `user_new1` |
| `${safepay_password}` | SafePay account password (4+ chars, lower, upper, number) | `NewPay1` |
| `${first_name}` | Shipping: first name | `Anna` |
| `${last_name}` | Shipping: last name | `Weber` |
| `${phone}` | Shipping: phone number | `+43177000001` |
| `${country}` | Shipping: country | `Austria` |
| `${city}` | Shipping: city | `Vienna` |
| `${address}` | Shipping: street address | `Ringstrasse 1` |
| `${postal_code}` | Shipping: postal code | `1010` |
| `${state}` | Shipping: state / region | `Wien` |
| `[Tags]` | Tag for filtering test runs | `register`, `register_mixed` |

### Tags

| Tag | Tests |
|-----|-------|
| `register` | Single product registration scenarios |
| `register_mixed` | Multi-product registration scenarios |

---

## products_string format

```
category|position|quantity ; category|position|quantity
```

- **category**: `tablets`, `laptops`, `speakers`, `mice`, `headphones`
- **position**: product position in the category list (1-based)
- **quantity**: number of items to add to cart

Example: `laptops|3|1;mice|1|2` — 1 laptop from position 3 and 2 mice from position 1.

---

## Run by tag

```bash
robot -d Output\ --include smoke C:\QA\AdvantageProject\TestCases\Purchase_Flow_Three_Products.robot
```

> Note: `--include` does not work with DataDriver. Use the `include=` parameter in the Library declaration inside the test file instead.
