# Collection Performance Dashboard

## Files (GitHub mein yahi 2 files chahiye)
- `collection_dashboard.html` — Dashboard (sirf ek baar upload)  
- `Colleciton_data1_1.csv` — Data file (**sirf isko replace karo naya data aane par**)

## Data Update Kaise Karein
1. Naya CSV file ko same naam se save karo: `Colleciton_data1_1.csv`
2. GitHub mein old CSV replace karo (upload karke overwrite)
3. Dashboard automatically naya data show karega ✅

Agar CSV ka naam badalna ho, `collection_dashboard.html` mein line no. ~4 par:
```js
const CSV_FILE = 'Colleciton_data1_1.csv';  // ← yahan naam badlo
```

## GitHub Pages Setup
1. New repo banao → dono files upload karo
2. Settings → Pages → Branch: main → Save
3. Live link: `https://[username].github.io/[repo-name]/collection_dashboard.html`
