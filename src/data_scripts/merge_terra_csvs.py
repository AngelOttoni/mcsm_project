import pandas as pd
from pathlib import Path

# Diretórios com os dados anuais
ppt_dir = Path('../../data/TerraClimate/ppt_data')
soil_dir = Path('../../data/TerraClimate/soil_data')

# Função para carregar e limpar arquivos
def load_and_clean_csv(filepath, variable_name):
    df = pd.read_csv(filepath)
    df = df.rename(columns={
        df.columns[0]: 'date',
        df.columns[1]: 'lat',
        df.columns[2]: 'lon',
        df.columns[3]: variable_name
    })
    df['date'] = pd.to_datetime(df['date'])
    return df[['date', variable_name]]

# Juntar precipitação
ppt_files = sorted(ppt_dir.glob('terraclimate_ppt_MOC_*.csv'))
ppt_all = pd.concat([load_and_clean_csv(f, 'ppt') for f in ppt_files])
ppt_all = ppt_all.sort_values('date')
ppt_all.to_csv('../../data/TerraClimate/ppt_data/ppt_moc_2003_2024.csv', index=False)
print(f"ppt: {len(ppt_all)} registros salvos em ppt_moc_2003_2024.csv")

# Juntar umidade do solo
soil_files = sorted(soil_dir.glob('terraclimate_soil_MOC_*.csv'))
soil_all = pd.concat([load_and_clean_csv(f, 'soil') for f in soil_files])
soil_all = soil_all.sort_values('date')
soil_all.to_csv('../../data/TerraClimate/soil_data/soil_moc_2003_2024.csv', index=False)
print(f"soil: {len(soil_all)} registros salvos em soil_moc_2003_2024.csv")