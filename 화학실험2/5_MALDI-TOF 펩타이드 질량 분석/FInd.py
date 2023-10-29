# -*- coding: utf-8 -*-
"""
Created on Sat Oct 28 19:34:06 2023

@author: QC109_4
"""

import re

exp_val = [303.992, 312.065, 317.955, 319.987, 332.054, 346.036, 348.056, 360.109, 
            374.093, 376.103, 378.813, 496.103, 508.030, 522.409, 550.464, 572.097,
            659.172, 689.142, 927.244, 1083.314, 1163.350, 1193.303, 1249.311, 1283.390,
           1305.396, 1439.467, 1479.436, 1567.353, 1639.547, 2192.462]

masses = {
    'G': 75.00,
    'S': 105.03,
    'V': 117.07,
    'C': 121.01,
    'I': 131.08,
    'D': 133.03,
    'K': 146.09,
    'M': 149.04,
    'A': 89.04,
    'P': 115.05,
    'T': 119.05,
    'L': 131.08,
    'N': 132.04,
    'Q': 146.06,
    'E': 147.04,
    'H': 155.06,
    'F': 165.07,
    'R': 174.10,
    'Y': 181.06,
    'W': 204.08
}

#https://www.rcsb.org/sequence/4MQJ
hemoglobin = "VHFTEEDKATITSLWGKVNVEDAGGETLGRLLVVYPWTQRFFDSFGNLSSASAIMGNPKVKAHGKKVLTSLGDAIKHLDDLKGTFAQLSELHCDKLHVDPENFKLLGNVLVTVLAIHFGKEFTPEVQASWQKMVTGVASALSSRYH"

#https://www.rcsb.org/structure/3GOU
# hemoglobin = "VLSPADKTNIKSTWDKIGGHAGDYGGEALDRTFQSFPTTKTYFPHFDLSPGSAQVKAHGKKVADALTTAVAHLDDLPGALSALSDLHAYKLRVDPVNFKLLSHCLLVTLACHHPTEFTPAVHASLDKFFAAVSTVLTSKYR"

#https://www.rcsb.org/sequence/2EKS
# lysozyme = "KVFGRCELAAAMKRHGLDNYRGYSLGNWVCAAKFESNFNTQATNRNTDGSTDYGILQINSRWWCNDGRTPGSRNLCNIPCSALLSSDITASVNCAKKIVSDGNGMNAWVAWRNRCKGTDVQAWIRGCRL"

#https://www.uniprot.org/uniprotkb/P61626/entry#sequences
lysozyme = "MKALIVLGLVLLSVTVQGKVFERCELARTLKRLGMDGYRGISLANWMCLAKWESGYNTRATNYNAGDRSTDYGIFQINSRYWCNDGKTPGAVNACHLSCSALLQDNIADAVACAKRVVRDPQGIRAWVAWRNRCQNRDVRQYVQGCGV"

#https://www.rcsb.org/3d-view/7JWN
bsa = "AHKSEVAHRFKDLGEENFKALVLIAFAQYLQQCPFEDHVKLVNEVTEFAKTCVADESAENCDKSLHTLFGDKLCTVATLRETYGEMADCCAKQEPERNECFLQHKDDNPNLPRLVRPEVDVMCTAFHDNEETFLKKYLYEIARRHPYFYAPELLFFAKRYKAAFTECCQAADKAACLLPKLDELRDEGKASSAKQRLKCASLQKFGERAFKAWAVARLSQRFPKAEFAEVSKLVTDLTKVHTECCHGDLLECADDRADLAKYICENQDSISSKLKECCEKPLLEKSHCIAEVENDEMPADLPSLAADFVESKDVCKNYAEAKDVFLGMFLYEYARRHPDYSVVLLLRLAKTYETTLEKCCAAADPHECYAKVFDEFKPLVEEPQNLIKQNCELFEQLGEYKFQNALLVRYTKKVPQVSTPTLVEVSRNLGKVGSKCCKHPEAKRMPCAEDYLSVVLNQLCVLHEKTPVSDRVTKCCTESLVNRRPCFSALEVDETYVPKEFNAETFTFHADICTLSEKERQIKKQTALVELVKHKPKATKEQLKAVMDDFAAFVEKCCKADDKETCFAEEGKKLVAASQAALGL"

#https://www.rcsb.org/3d-view/1UHG
ovalbumin = "GSIGAASMEFCFDVFKELKVHHANENIFYCPIAIMSALAMVYLGAKDSTRTQINKVVRFDKLPGFGDSIEAQCGTSVNVHSSLRDILNQITKPNDVYSFSLASRLYAEERYPILPEYLQCVKELYRGGLEPINFQTAADQARELINSWVESQTNGIIRNVLQPSSVDSQTAMVLVNAIVFKGLWEKAFKDEDTQAMPFRVTEQESKPVQMMYQIGLFRVASMASEKMKILELPFASGTMSMLVLLPDEVSGLEQLESIINFEKLTEWTSSNVMEERKIKVYLPRMKMEEKYNLTSVLMAMGITDVFSSSANLSGISSAESLKISQAVHAAHAEINEAGREVVGSAEAGVDAASVSEEFRADHPFLFCIKHIATNAVLFFGRCVSP"
#Hemo
print('###############################\nHEMO\n###############################')
pep_hemoglobin = []
mass_hemoglobin = []
pep = ''
for comp in hemoglobin:
    if comp == 'K' or comp == 'R':
        pep += comp
        pep_hemoglobin.append(pep)
        pep = ''
    else:
        pep += comp

# Sort pep_hemoglobin by mass
pep_hemoglobin.sort(key=lambda x: sum(masses[c] for c in x))

# Print sorted peptides with their masses
for pep_comp in pep_hemoglobin:
    mass = sum(masses[comp] for comp in pep_comp)
    mass_hemoglobin.append(mass)
    print(f'{pep_comp} & {mass:.2f}\\\\')

#Lyso    
print('###############################\nLSYO\n###############################')
pep_lysozyme = []
mass_lysozyme = []
pep = ''
for comp in lysozyme:
    if comp == 'K' or comp == 'R':
        pep += comp
        pep_lysozyme.append(pep)
        pep = ''
    else:
        pep += comp

# Sort pep_lysozyme by mass
pep_lysozyme.sort(key=lambda x: sum(masses[c] for c in x))

# Print sorted peptides with their masses
for pep_comp in pep_lysozyme:
    mass = sum(masses[comp] for comp in pep_comp)
    mass_lysozyme.append(mass)
    print(f'{pep_comp} & {mass:.2f}\\\\')
    
#BSA   
print('###############################\nBSA\n###############################')
pep_bsa = []
mass_bsa = []
pep = ''
for comp in bsa:
    if comp == 'K' or comp == 'R':
        pep += comp
        pep_bsa.append(pep)
        pep = ''
    else:
        pep += comp

# Sort pep_bsa by mass
pep_bsa.sort(key=lambda x: sum(masses[c] for c in x))

# Print sorted peptides with their masses
for pep_comp in pep_bsa:
    mass = sum(masses[comp] for comp in pep_comp)
    mass_bsa.append(mass)
    print(f'{pep_comp} & {mass:.2f}\\\\')
    
#BUMIN 
print('###############################\nBUMIN\n###############################')
pep_ovalbumin = []
mass_ovalbumin = []
pep = ''
for comp in ovalbumin:
    if comp == 'K' or comp == 'R':
        pep += comp
        pep_ovalbumin.append(pep)
        pep = ''
    else:
        pep += comp

# Sort pep_ovalbumin by mass
pep_ovalbumin.sort(key=lambda x: sum(masses[c] for c in x))

# Print sorted peptides with their masses
for pep_comp in pep_ovalbumin:
    mass = sum(masses[comp] for comp in pep_comp)
    mass_ovalbumin.append(mass)
    print(f'{pep_comp} & {mass:.2f}\\\\')
    
print()

print('m/z & hemoglobin & lysozyme & BSA & ovalbumin \\\\')
cov_hemoglobin = 0
cov_lysozyme = 0
cov_bsa = 0
cov_ovalbumin = 0

base = 2.5

exp_val = [x - 1 for x in exp_val]

for exp_comp in exp_val: 
    print(f'{exp_comp:.2f} & ', end = '')
    min_pep = ''
    min_val = float('inf')
    for mass in mass_hemoglobin:
        if ( exp_comp - mass ) ** 2 < min_val:
            min_val = ( exp_comp - mass ) ** 2
            min_pep = 'HEMO'
            percent = (exp_comp - mass)/exp_comp * 100
    print(f'{percent:.2f}\\% &', end = '')
    if abs(percent) < base:
        cov_hemoglobin += 1
    
    min_val = float('inf')
    for mass in mass_lysozyme:
        if ( exp_comp - mass ) ** 2 < min_val:
            min_val = ( exp_comp - mass ) ** 2
            min_pep = 'LYSO'
            percent = (exp_comp - mass)/exp_comp * 100
    print(f'{percent:.2f}\\% &', end = '')
    if abs(percent) < base:
        cov_lysozyme += 1
    
    min_val = float('inf')
    for mass in mass_bsa:
        if ( exp_comp - mass ) ** 2 < min_val:
            min_val = ( exp_comp - mass ) ** 2
            min_pep = 'BSA'
            percent = (exp_comp - mass)/exp_comp * 100
    print(f'{percent:.2f}\\% &', end = '')
    if abs(percent) < base:
        cov_bsa += 1
     
    min_val = float('inf')
    for mass in mass_ovalbumin:
        if ( exp_comp - mass ) ** 2 < min_val:
            min_val = ( exp_comp - mass ) ** 2
            min_pep = 'OVALBUMIN'
            percent = (exp_comp - mass)/exp_comp * 100
    print(f'{percent:.2f}\\%\\\\')
    if abs(percent) < base:
        cov_ovalbumin += 1
    
        
print(f'coverage & {cov_hemoglobin/len(exp_val) * 100:.2f}\\% & { cov_lysozyme/len(exp_val) * 100:.2f}\\% & {  cov_bsa/len(exp_val) * 100:.2f}\\% & {cov_ovalbumin/len(exp_val) * 100:.2f}\\% ')
            
    # print(str(exp_comp) + ' & ' + min_pep)
    
    #OUR is HEMO? Since there is no 1280 peak in LYSO...