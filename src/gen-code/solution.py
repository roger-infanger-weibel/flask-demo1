import os

folder_path = r'C:\Users\Hp\VSC-Work\src\gen-code'
file_name = 'solution.md'
filel_path = os.path.join(folder_path, file_name)

f=open(filel_path,'r')

os.remove("solution-table.csv") if os.path.exists("solution-table.csv") else None
with open("solution-table.csv", "a") as out:
    out.write("# Generate Table\n")
    out.write("This table was generated using the md file (python)\n")
    out.write("<table>\n")
    out.write("<tr>\n")
    out.write("<th>Category</th>\n")
    out.write("<th>Requirement</th>\n")
    out.write("<th>Fit Criteria</th>\n")
    out.write("<th>Owner</th>\n")
    out.write("<th>Coverage</th>\n")
    out.write("</tr>\n")

    pending_h2=False
    pending_h3=False


    for rec in f:
        if len(rec.split()) > 0:
            if rec[:2] == '# ':
                h1=rec[2:].strip()
                pending_h2=True
            if rec[:3] == '## ':
                if pending_h3 == True:
                    print("Error: this last h2 did not had any h3:",h2)
                h2=rec[3:].strip()
                pending_h2=False
                pending_h3=True
            if rec[:4] == '### ':
                pending_h3=False
                h3=rec[4:].strip()
                out.write("<tr>\n")
                out.write("<td>"+h1+"</td>\n")
                out.write("<td>"+h2+"</td>\n")
                addon = h3.split()[-1]
                owner="?"
                coverage="?"
                if addon == "=ibm-feat":
                    owner="ibm"
                    coverage="= feature"
                    h3 = h3.rsplit(' ', 1)[0]
                if addon == "-ibm-gap":
                    owner="ibm"
                    coverage="- gap"
                    h3 = h3.rsplit(' ', 1)[0]
                if addon == "+ibm-req":
                    owner="ibm"
                    coverage="+ request"
                    h3 = h3.rsplit(' ', 1)[0]
                if addon == "=own":
                    owner="us"
                    coverage="prototype"
                    h3 = h3.rsplit(' ', 1)[0]
                if owner == '?':
                    print("Error: unknown label in h3:",addon + "(" + h3 + ")")
                
                out.write("<td>"+h3+"</td>\n")
                out.write("<td>"+owner+"</td>\n")
                out.write("<td>"+coverage+"</td>\n")
                out.write("</tr>\n")

                pending_h2=False

    out.write("</table>\n")
