# -*- coding: utf-8 -*-
"""
Created on Sun May  2 18:14:57 2021

@author: marka
"""

from bs4 import BeautifulSoup
import requests
import json

baseUrl = 'https://www.lolskill.net/champions'


champsListGet = requests.get(baseUrl)

champsSoup = BeautifulSoup(champsListGet.content, 'html.parser')
champsSoup = champsSoup.find(id='championList')
champsSoup = champsSoup.findAll(class_='name mr-auto text-left')

champsList = []

for champ in champsSoup:
    champsList.insert(0,champ.find(class_='value champion-name').string)


abilitiesDict = {}
    
for champ in champsList:
    champ = champ.lower()
    champUrl = f"{baseUrl[:-1]}/{champ}"
    #col-12 col-lg-4 ml-auto
    champGet = requests.get(champUrl)
    champSoup = BeautifulSoup(champGet.content, 'html.parser')
    abilitiesSoup = champSoup.find_all(class_='col-12')
    for ability in abilitiesSoup:
        if ability.find('h5') is not None:
            abilityName = ability.find('h5').string      
            if ability.find(class_='attributes row') is not None:
                abilityValues = ability.find_all(class_='col-12 col-lg-4 ml-auto')
            if abilityValues[1].find(class_='value') is not None:
                abilityRange = abilityValues[1].find(class_='value').string
            else:
                abilityRange = 0
            abilitiesDict[abilityName] = abilityRange   

with open('abilityRanges.txt','w') as f:
    f.write(json.dumps(abilitiesDict))
                    