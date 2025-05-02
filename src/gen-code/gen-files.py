import pandas as pd
import os

# Path to your Excel file
folder_path = r'C:\Users\Hp\Documents\ibm-wazi-deploy'
file_name = 'usecase-dev-to-prod-szenarios.xlsx'
excel_path = os.path.join(folder_path, file_name)
print(excel_path)

# Output directory for the files
output_dir = 'components'
os.makedirs(output_dir, exist_ok=True)

# Load the 'Main' sheet
df = pd.read_excel(excel_path, sheet_name='Main')

# Drop rows where 'Component Name' is missing
df = df[df['Component Name'].notnull()]

# Loop through each component and create a file
for idx, row in df.iterrows():
    output_dir = 'components'+ '//' +  str(row['Applicatication']).strip()
    os.makedirs(output_dir, exist_ok=True)

    component_name = str(row['Component Name']).strip()
    component_type = str(row['Type']).strip()
    application = str(row['Applicatication']).strip() if pd.notnull(row['Applicatication']) else ''
    category = str(row['Component Category']).strip() if pd.notnull(row['Component Category']) else ''
    
    # Define the filename (you can change the extension if needed)
    filename = os.path.join(output_dir, component_name+"."+component_type)
    print(filename)
    # Basic content for the file (customize as needed)
    content = f"""Application: {application} Category: {category} Component: {component_name} """
    
    # Write the file
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(content)

print(f"Created {len(df)} files in '{output_dir}' directory.")
