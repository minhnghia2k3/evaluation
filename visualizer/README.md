# COVID-19 Vietnam Data Visualizer

Interactive dashboard visualizing COVID-19 survey data from Vietnam (12,074 responses across 12 weeks).

## Features

- 7 chart types: Line, Area, Pie, Stacked Bar, Scatter, Bar, Horizontal Bar
- Time range filter (week selection)
- Region filter (6 regions)
- Click mini charts to view full detail
- Interactive charts (hover, zoom, pan via Recharts)
- Mobile-first responsive design
- Dark theme UI

## Stack

- **Frontend:** React + Vite, TailwindCSS 4, Recharts, React Router
- **Backend:** Flask, Pandas
- **Package Manager:** pnpm (frontend), uv (backend)

## Setup

### Backend

```bash
cd backend
uv venv
source .venv/bin/activate
uv pip install -r requirements.txt
python app.py
```

Backend runs on `http://localhost:5001`

### Frontend

```bash
cd frontend
pnpm install
pnpm dev
```

Frontend runs on `http://localhost:5173`

## Data Source

[YouGov COVID-19 Tracker - Vietnam](https://github.com/YouGov-Data/covid-19-tracker/blob/master/data/vietnam.csv)

## Charts

1. **Health Rating Over Time** - Line chart showing average health rating by week
2. **COVID Concern Over Time** - Area chart of average concern levels
3. **Regional Distribution** - Pie chart of responses by region
4. **Testing Status** - Stacked bar chart of testing status per week
5. **Age vs Health by Gender** - Scatter plot showing correlation
6. **Life Satisfaction** - Bar chart of Cantril ladder scores
7. **Employment Status** - Horizontal bar chart of employment breakdown
