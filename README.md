# Singapore Schools (SCTP Capstone 2)
## _A study of Singapore Schools and their enrichment programmes_

### Context 
Persona: I work for a comapny that is trying to provide enrichment programmes to students to enhance their educational journey. 
[Link to Dataset](https://www.kaggle.com/datasets/subhamjain/schools-information-directory-singapore)

![ERD](https://i.gyazo.com/00f941ff88a503e84e1a81afa34013db.png)

![Schema](https://i.gyazo.com/da96684bdef45060a49c544996449a02.png)

### Analysis 
- Of the schools with special programmes, there is a great emphasis on STEM programmes
![STEM](https://i.gyazo.com/e99087c1e52504509d39fffd22ae8468.png)
![SQL](https://i.gyazo.com/9c65af7e3d931bd2c9c007363d6af4c7.png)

- 58 of 346 schools in Singapore does not have special enrichment programmes and of this 34 are secondary schools 
![SQL](https://i.gyazo.com/4f4eaf527935152ad0c2731a165cb7d5.png)

- Locations of schools with special programmes 
![SQL](https://i.gyazo.com/ff45cc20e11ddbba2dbc622908e597ad.png)
![Sunburst](https://i.gyazo.com/79430b7b6816bae26a4906665296c84f.png)
![Sunburst](https://i.gyazo.com/e19371cbafc584f46ca349f7e1b6a725.png)

### Data Cleaning 
The dataset provide 5 csv files 
- general information of the schools
    - removed columns that were not needed
    - split location, school type, school nature, school mainlevel into its own tables to fulfil 3NF
- cca
    - linked to the general school information table 
- subjects offered
    - linked to the general school information table     
- moe programmes
    - linked to the general school information table   
- school distinctive programmes
    -  split into 2 tables to fufil 3NF
    -  linked to the general school information table   

Challenges: 
While trying to link my tables to the general information table, I was encountering an error message in postgre that said "schools.school_id " does not exist. It took me a long time before I realise that it was because there was a space in the header and that i needed to upload the csv again without the space. 
