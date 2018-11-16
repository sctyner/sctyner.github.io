---
layout: post
title: "Where does the U.S. Government Keep its Data?"
date: "2018-11-16 10:13:19 CST"
categories: blog, data, government
---



### If the post looks funky use [this](../static/presentations/Misc/GraphicsGroupISU/2018-11-16-us-govt-data.html) instead. 

### Non-exhaustive list of R Package Sources for getting government data: 

- [`federalregister`](https://github.com/rOpenGov/federalregister)
- [`ropengov`](http://ropengov.github.io/projects/)
- [`censusapi`](https://cran.r-project.org/web/packages/censusapi/censusapi.pdf)
- [`censusr`](https://github.com/transportfoundry/censusr)
- [`tidycensus`](https://www.r-pkg.org/pkg/tidycensus)
- [`elevater`](https://cfpub.epa.gov/si/si_public_record_report.cfm?Lab=NHEERL&direntryid=335983)

# Principal Statistical Agency Programs

Inspiration and primary source for all of this information: [Statistical Programs of the United States Government Fiscal Year 2017](https://obamawhitehouse.archives.gov/sites/default/files/omb/assets/information_and_regulatory_affairs/statistical-programs-2017.pdf)


"The Federal Statistical System of the United States is the decentralized network of federal agencies which produce data about the people, economy, natural resources, and infrastructure of the United States." ([Wikipedia](https://en.wikipedia.org/wiki/Federal_Statistical_System_of_the_United_States)) 

I recently got the opportunity to visit the offices of the [Committee on National Statistics](http://sites.nationalacademies.org/dbasse/cnstat/index.htm) and I realized I had no idea just how much statistical work the Federal government does. Before this, the only statistical agency I really knew about was the Census Bureau. Based on my complete and total ignorance about all of the work done and data collected by the U.S. federal government, I decided to compile together as many sources of data as I could. Wherever possible, I tried to find APIs. This list is also probably not exhaustive. There is also way more data from state and local governments on [data.gov](https://www.data.gov/), but I have not found this site to be particularly helpful when just looking for possible interesting data sources. It's better for very specific searches in my opinion. 

These 13 principal agencies are crucial to collecting data on the population and resources of the United States. They "provide critical support for policymaking, program management, and evaluation." Two of the 13 are independent: the National Center for Science and Engineering Statistics (NCSES), a part of the National Science Foundation (NSF), and the Office of Research, Evaluation, and Statistics (ORES), a part of the Social Security Administration (SSA). 

(If you're exhausted by the alphabet soup already, I suggest you stop reading....)

The report linked at the top contains descriptions of every agency and every statistical program. It also links to every program's website and provides employment data tables for the 13 principal agencies. Below, the numbers (x/y) are x = the number of statisticians employed and y = the number of full-time employees in the agency as of 2017. 

1. Bureau of Economic Analysis (BEA): (12/509 $\approx$ 2%) 
    - Description: "BEA is responsible for the preparation, development, and interpretation of the Nation's economic accounts." 
    - Home Agency: Department of Commerce (DOC)
    - [Website](https://www.bea.gov/)
    - [API](https://apps.bea.gov/API/signup/index.cfm)
2. Bureau of Justice Statistics (BJS): (42/69  $\approx$ 61%)
    - Description: "BJS collects, analyzes, publishes, and disseminates statistical information on all aspects of the criminal justice system; assists State, Tribal, and local governments in gathering and
analyzing justice statistics; and disseminates high value information and statistics to inform policymakers, researchers, criminal justice practitioners and the general public." 
    - Home Agency: Department of Justice (DOJ)
    - [Website](https://www.bjs.gov/)
    - [Data](https://www.bjs.gov/datacollection.cfm)
3. Bureau of Labor Statistics (BLS): (168/2167  $\approx$ 8%)
    - Description: "BLS is responsible for measuring labor market activity, working conditions, and price changes in the economy."
    - Home Agency: Department of Labor (DOL)
    - [Website](https://www.bls.gov/)
    - [API](https://www.bls.gov/developers/api_r.htm) (An R script for accessing their API!!)
4. Bureau of Transportation Statistics (BTS): (15/84  $\approx$ 18%) 
    - Description: "BTS compiles, analyzes, and disseminates information about the Nation's transportation systems, including the extent, use, condition, performance, and consequences of those systems."
    - Home Agency: Department of Transportation (DOT)
    - [Website](https://www.bts.gov/)
    - [Data](https://www.bts.gov/browse-statistical-products-and-data) (an  [app](https://www.bts.gov/browse-statistical-products-and-data/pocket-guide-transportation/pocket-guide-transportation)) 
5. Census Bureau (Census): (2311/6551 $\approx$ 35%)
    - Description: "Census measures and disseminates information about the Nation’s ever-changing economy, society, and institutions." 
    - Home Agency: DOC
    - [Website](https://www.census.gov/)
    - [APIs (plural!)](https://www.census.gov/data/developers/data-sets.html)
6. Economic Research Service (ERS): (1/359  $\approx$ .3%) 
    - Description: "ERS provides economic and other social science research and analysis to inform public and private decision making on agriculture, food, natural resources, and rural America."
    - Home Agency: United States Department of Agriculture (USDA)
    - Website: https://www.ers.usda.gov/
    - ~~API~~ Prayer directed at Excel files here: https://www.ers.usda.gov/data-products/
    - Bonus: Cool sounding [postdoc gig](https://www.ers.usda.gov/about-ers/careers-at-ers/employment-opportunities/data-scientist-post-doctoral-position/). Application due November 19, 2018!
7. Energy Information Administration (EIA): (75/368  $=$ 20%)
    - Description: "EIA collects, analyzes, and disseminates independent and impartial energy information to promote sound policymaking, efficient markets, and public understanding of energy and its interaction with the economy and the environment."
    - Home Agency: Department of Energy (DOE)
    - Website: https://www.eia.gov
    - API: https://www.eia.gov/opendata/qb.php
8. National Agricultural Statistics Service (NASS): (634/1037  $\approx$ 61%)  
    - Description: " NASS collects, summarizes, analyzes, and publishes data on the number of farms and land in farms; acreage, yield, production, and stocks of crops; inventories and production of livestock, including eggs and dairy products; prices received by farmers for products, prices paid for commodities and services, and related indexes; agriculture production and marketing data; cold storage supplies; agricultural chemical use; and other related areas of the agricultural economy."
    - Home Agency: USDA
    - Website: https://www.nass.usda.gov/
    - API: https://quickstats.nass.usda.gov/api (This was hard to find.)
9. National Center for Education Statistics (NCES): (71/93  $\approx$ 76%) 
    - Description: "NCES collects, analyzes, and disseminates education statistics at all levels, from preschool through postsecondary and adult education, including statistics on international education."
    - Home Agency: Department of Education (ED)
    - Website: https://nces.ed.gov/
    - ~~API~~ Good luck: https://nces.ed.gov/pubsearch/ , https://nces.ed.gov/datatools/ 
10. National Center for Health Statistics (NCHS): (164/503  $\approx$ 33%)  
    - Description: "NCHS is responsible for the collection, maintenance, analysis, and dissemination of statistics on the nature and extent of the health, illness, and disability of the U.S. population; the impact of illness and disability on the economy; the effects of environmental,
social, and other health hazards; health care costs and financing; family formation, growth, and dissolution; and vital events (births and deaths)."
    - Home Agency: Department of Health and Human Services (HHS)
    - Website: https://www.cdc.gov/nchs/
    - API: Supposedly http://www.healthindicators.gov/ and https://ephtracking.cdc.gov/apihelp and https://wonder.cdc.gov/ and https://www.cdc.gov/sdp/SDPForDevelopers.html. 
11. National Center for Science and Engineering Statistics (NCSES): (25/52  $\approx$ 48%) 
    - Description: "NCSES is called on to support the collection of statistical data on research and development trends, the science and engineering workforce, U.S. competitiveness, and the condition and progress of the Nation’s science, technology, engineering, and mathematics (STEM) education; to support research using the data it collects and on methodologies in areas related to the work of the Center; and to support the education and training of researchers in the use of its own and other large-scale, nationally representative data sets."
    - Home Agency: NSF
    - Website: https://www.nsf.gov/statistics/ 
    - ~~API~~ Prayer and patience: https://www.nsf.gov/statistics/data-tools.cfm
12. Office of Research, Evaluation, and Statistics (ORES): (3/66  $\approx$ 5%)
    - Description: "ORES performs demographic and socioeconomic research to assess the impact of program changes or alternatives."
    - Home Agency: SSA
    - Website: https://www.ssa.gov/policy/about/ORES.html
    - ~~API~~ Prayer: https://www.ssa.gov/policy/docs/data/index.html 
13. Statistics of Income (SOI): (25/116  $\approx$ 22%)
    - Description: "SOI collects, analyzes, and disseminates information
on the Federal tax system."
    - Home Agency: Internal Revenue Service (IRS)
    - Website: https://www.irs.gov/statistics/soi-tax-stats-about-soi
    - ~~API~~ 🤷: https://www.irs.gov/statistics/soi-tax-stats-release-and-dissemination 

# Other Federal Statistical Programs, by Department 

Of the fifteen US federal government departments, fourteen have additional statistical programs (outside of the 13 principal statistical agencies), and there are even more programs in independent agencies. There are 115 of these statistical programs in total (yes, I counted them). For each one, I just link to the closest thing to a data website I could find. 

1. Department of Agriculture : https://www.usda.gov/media/digital/developer-resources 
    a. Agricultural Research Service (ARS) : https://www.ars.usda.gov/research/datasets/
    b. Food and Nutrition Service (FNS) : https://www.fns.usda.gov/data-and-statistics
    c. Foreign Agricultural Service (FAS) : https://www.fas.usda.gov/data
    d. Forest Service (FS) : closest I could find to a data warehouse https://www.fs.fed.us/publications
    e. Natural Resources Conservation Service (NRCS) : https://www.nrcs.usda.gov/wps/portal/nrcs/detail/national/home/?cid=stelprdb1049255
    f. Risk Management Agency (RMA) : https://www.rma.usda.gov/ under the "Tools" menu
    g. World Agricultural Outlook Board (WAOB) : (just some reports) https://www.usda.gov/oce/commodity/index.htm

2. Department of Commerce : APIs linked + code on Github!!!! https://github.com/CommerceGov/commerce.gov-api 
    a. Economics and Statistics Administration (ESA) : https://www.commerce.gov/bureaus-and-offices/ousea 
    a. International Trade Administration (ITA) : API here: https://developer.trade.gov/ 
    a. National Oceanic and Atmospheric Administration (NOAA) : https://www.ncdc.noaa.gov/cdo-web/webservices/v2  (R Package https://cran.r-project.org/web/packages/rnoaa/index.html) 
    a. National Environmental Satellite, Data, and Information Service (NESDIS) : Cool maps and other viz  https://www.nesdis.noaa.gov/content/imagery-and-data 
    a. Marine Fisheries Service (NMFS) : https://www.fisheries.noaa.gov/resources/data-and-maps
    a. Patent and Trademark Office (PTO) : https://www.uspto.gov/learning-and-resources/open-data-and-mobility

3. Department of Defense : https://data.defense.gov/ 
    a. Army Corps of Engineers (ACE) : https://www.iwr.usace.army.mil/about/technical-centers/wcsc-waterborne-commerce-statistics-center/
    a. Defense Health Agency (DHA) : https://health.mil/Military-Health-Topics/Health-Readiness/Armed-Forces-Health-Surveillance-Branch/Data-Management-and-Technical-Support 
    a. Defense Manpower Data Center (DMDC) : https://www.dmdc.osd.mil/appj/dwp/data_reqs.jsp

4. Department of Education: https://www2.ed.gov/rschstat/catalog/index.html, https://eddataexpress.ed.gov/?src=ft , https://usedgov.github.io/, https://usedgov.github.io/api/ 
    a. Institute of Education Sciences (IES) : https://ies.ed.gov/data.asp
    a. Office of Career, Technical, and Adult Education (OCTAE) : https://www2.ed.gov/about/offices/list/ovae/resource/index.html 
    a. Office for Civil Rights (OCR) : https://ocrdata.ed.gov/
    a. Office of Elementary and Secondary Education (OESE) : https://www2.ed.gov/about/offices/list/oese/resources.html
    a. Office of Innovation and Improvement (OII) : https://innovation.ed.gov/resources/
    a. Office of Planning, Evaluation, and Policy Development (OPEPD) : https://www2.ed.gov/about/offices/list/opepd/reports.html
    a. Office of Postsecondary Education (OPE) : https://nces.ed.gov/ipeds/use-the-data 
    a. Office of Special Education and Rehabilitative Services (OSERS) : https://rsa.ed.gov/

5. Department of Energy : https://www.energy.gov/data/open-energy-data 
    a. Office of Environment, Health, Safety, and Security (OEHSS) : https://www.energy.gov/ehss/policy-guidance-reports/databases 

6. Department of Health and Human Services : https://www.hhs.gov/developer.html, https://healthdata.gov/
    a. Administration for Children and Families (ACF) : https://www.acf.hhs.gov/reports#block-acf-theme-opre-reports 
    b. Administration for Community Living (ACL) : https://agid.acl.gov/ 
    c. Agency for Healthcare Research and Quality (AHRQ) : https://www.ahrq.gov/data/resources/index.html 
    d. Centers for Disease Control and Prevention (CDC) : https://data.cdc.gov/ ; https://github.com/CDCgov . 
        i. Agency for Toxic Substance and Disease Registry (ATSDR) : https://www.atsdr.cdc.gov/publications_data_resources.html
        ii. Center for Global Health : https://www.cdc.gov/globalhealth/index.html
        iii. National Center on Birth Defects and Developmental Disabilities (NCBDDD) : https://www.cdc.gov/ncbddd/index.html 
        i. National Center for Chronic Disease Prevention and Health Promotion (NCCDPHP) : https://www.cdc.gov/chronicdisease/data/indicators.htm 
        i. National Center for Emerging Zoonotic and Infectious Diseases (NCEZID) : https://www.cdc.gov/ncezid/multimedia/infographics.html 
        i. National Center for Environmental Health (NCEH) : https://www.cdc.gov/nceh/data.htm
        i. National Center for HIV/AIDS, Viral Hepatitis, Sexually Transmitted Disease, and Tuberculosis Prevention (NCHHSTP) : https://www.cdc.gov/nchhstp/data-tools-resources.htm
        i. National Center for Immunization and Respiratory Diseases (NCIRD) : https://www.cdc.gov/ncird/
        i. National Center for Injury Prevention and Control (NCIPC) : https://www.cdc.gov/injury/wisqars/index.html 
        i. National Institute for Occupational Safety and Health (NIOSH) : https://www.cdc.gov/niosh/data/default.html 
        i. Office of Public Health Scientific Services (PHSS) : https://www.cdc.gov/cpr/ 
    a. Centers for Medicare and Medicaid Services (CMS) : https://www.cms.gov/Research-Statistics-Data-and-Systems/Research-Statistics-Data-and-Systems.html
    a. Health Resources and Services Administration (HRSA) : https://data.hrsa.gov/
    a. Indian Health Service (IHS) : https://www.ihs.gov/dps/
    a. National Institutes of Health (NIH) : https://www.nimhd.nih.gov/resources/reports-data.html, https://ghr.nlm.nih.gov/about/data-files-api, https://report.nih.gov/databases.aspx
      i. National Cancer Institute (NCI)  : https://api.seer.cancer.gov/, https://clinicaltrialsapi.cancer.gov/ , https://www.cancer.gov/search/results?swKeyword=api
      i. National Center for Complementary and Integrative Health (NCCIH) : https://nccih.nih.gov/research/statistics 
      i. National Eye Institute (NEI) : https://nei.nih.gov/eyedata
      i. National Heart, Lung, and Blood Institute (NHLBI) : https://www.nhlbi.nih.gov/science
      i. National Human Genome Research Institute (NHGRI) : https://www.genome.gov/policyethics/legdatabase/pubsearch.cfm, https://www.genome.gov/10000018/computational-and-statistical-genomics-branch-csgb/
      i. National Institute on Aging (NIA) : https://www.nia.nih.gov/research/resources
      i. National Institute on Alcohol Abuse and Alcoholism (NIAAA) : https://www.niaaa.nih.gov/research/guidelines-and-resources/epidemiologic-data
      i. National Institute of Allergy and Infectious Diseases (NIAID) :  https://www.niaid.nih.gov/research/resources
      i. National Institute of Biomedical Imaging and Bioengineering (NIBIB) :  https://www.nibib.nih.gov/
      i. National Institute of Child Health and Human Development (NICHD) :  https://www.nichd.nih.gov/research/resources/index
      i. National Institute on Deafness and Other Communication Disorders (NIDCD) : https://www.nidcd.nih.gov/
      i. National Institute of Dental and Craniofacial Research (NIDCR) : https://www.nidcr.nih.gov/research/data-statistics
      i. National Institute of Diabetes and Digestive and Kidney Diseases (NIDDK) : https://www.niddk.nih.gov/research-funding/research-resources
      i. National Institute on Drug Abuse (NIDA) : https://github.com/nih-nida 
      i. National Institute of Environmental Health Sciences (NIEHS) : https://www.niehs.nih.gov/research/resources/databases/index.cfm
      i. National Institute of General Medical Sciences’ (NIGMS) : https://www.nigms.nih.gov/education/other-resources
      i. National Institute of Mental Health (NIMH) : https://www.nimh.nih.gov/health/statistics/index.shtml 
      i. Office of the Director (NIH/OD) : https://acd.od.nih.gov/working-groups.html 
    a. Office of the Assistant Secretary for Planning and Evaluation (ASPE) : https://aspe.hhs.gov/basic-search/data 
    a. Office of Population Affairs (OPA) : https://www.hhs.gov/opa/
    a. Substance Abuse and Mental Health Services Administration (SAMHSA) : https://www.samhsa.gov/data/all-reports  

1. Department of Homeland Security : https://www.dhs.gov/dhs-developer-community
    a. Citizenship and Immigration Services (CIS) : https://www.uscis.gov/tools/reports-studies/immigration-forms-data 
    a. Coast Guard : https://www.uscg.mil/
    a. Customs and Border Protection (CBP) : https://www.cbp.gov/trade/itrac-requests, https://www.cbp.gov/newsroom/stats
    a. Federal Emergency Management Agency’s (FEMA) : https://www.fema.gov/data-visualization, https://www.fema.gov/data-feeds 
    a. Office of Immigration Statistics (OIS) : https://www.dhs.gov/immigration-statistics (Link was broken last I checked...) 

1.  Department of Housing and Urban Development : https://data.hud.gov/
    a. Office of Housing (Housing) : https://www.hud.gov/program_offices/housing
    a. Office of Policy Development and Research (PD&R) : https://www.huduser.gov/portal/pdrdatas_landing.html
    a. Office of Public and Indian Housing (PIH) : https://www.hud.gov/program_offices/public_indian_housing/ih/pubs

1. Department of the Interior : https://www.doi.gov/data, https://data.doi.gov/dataset
    a. Bureau of Land Management (BLM) : https://www.blm.gov/about/data
    a. Bureau of Ocean Energy Management (BOEM) : https://www.boem.gov/Maps-and-GIS-Data/, https://www.boem.gov/Renewable-Energy-Program-Mapping-and-Data/, https://www.data.boem.gov/ (woof)
    a. Bureau of Reclamation (BoR)  : https://water.usbr.gov/ , https://www.usbr.gov/rsvrWater/HistoricalApp.html
    a. Fish and Wildlife Service (FWS) : https://www.fws.gov/southeast/data-management/, https://www.fws.gov/gis/data/national/
    a. Geological Survey (GS) : https://www.usgs.gov/products/data-and-tools/overview (NICE!)
    a. National Park Service (NPS) : https://www.nps.gov/gis/data_info/, https://irma.nps.gov/DataStore/, https://www.nps.gov/subjects/digital/nps-data-api.htm
    a. Office of Natural Resources Revenue (ONRR) : https://revenuedata.doi.gov/explore/#federal-disbursements, https://www.onrr.gov/About/production-data.htm

1. Department of Justice : https://www.justice.gov/developer , https://data.ojp.gov/developer/index.html 
    a. Bureau of Prisons’ (BOP) : http://prisondb.github.io/bopapidocs.html (not affiliated with bop.gov), https://www.bop.gov/about/statistics/
    a. Drug Enforcement Administration (DEA) : https://www.dea.gov/data-and-statistics, https://dea.ntis.gov/
    a. Federal Bureau of Investigation’s (FBI) : https://www.fbi.gov/wanted/api, https://crime-data-explorer.fr.cloud.gov/api
    a. National Institute of Justice (NIJ) : https://www.nij.gov/journals/258/Pages/forensic-databases.aspx,  https://www.nij.gov/funding/data-resources-program/Pages/accessing.aspx
    a. Office of Juvenile Justice and Delinquency Prevention (OJJDP) : https://www.icpsr.umich.edu/icpsrweb/content/NACJD/archiving/deposit-ojjdp-data.html, https://www.ojjdp.gov/ojstatbb/dat.htmlm https://www.ojjdp.gov/ojstatbb/ezapop/

1. Department of Labor: https://enforcedata.dol.gov/homePage.php, https://developer.dol.gov/ 
    a. Chief Evaluation Office (CEO) : https://www.dol.gov/asp/evaluation/PublicUseData.htm
    a. Employment and Training Administration (ETA)  : https://www.doleta.gov/research/
    a. Mine Safety and Health Administration (MSHA) : https://www.msha.gov/data-reports/data-sources-calculators
    a. Occupational Safety and Health Administration (OSHA) : https://www.osha.gov/oshstats/index.html
    a. Office of Federal Contract Compliance Programs (OFCCP) : https://www.dol.gov/ofccp/BTN/index.html
    a. Wage and Hour Division (WHD) : https://catalog.data.gov/dataset/whd-compliance-full

1. Department of State : https://www.state.gov/api/v1/docs/, https://www.state.gov/developer/, https://www.state.gov/data/
    a. Office of the U.S. Global AIDS Coordinator (OGAC) :https://www.pepfar.gov/priorities/data/index.htm, https://www.hiv.gov/locator#api 

1. Department of Transportation : https://www.transportation.gov/developer
    a. Federal Aviation Administration (FAA) : https://www.faa.gov/data_research/
    a. Federal Highway Administration (FHWA) : https://infopave.fhwa.dot.gov/Data/DataSelection
    a. Federal Motor Carrier Safety Administration (FMCSA) : https://dataqs.fmcsa.dot.gov
    a. Federal Railroad Administration (FRA) : https://safetydata.fra.dot.gov/officeofsafety/publicsite/downloaddbf.aspx
    a. Federal Transit Administration (FTA) : https://www.transit.dot.gov/ntd
    a. National Highway Traffic Safety Administration (NHTSA) : https://www.nhtsa.gov/research-data
    a. Pipeline and Hazardous Materials Safety Administration (PHMSA) : https://www.phmsa.dot.gov/data-and-statistics/pipeline/data-and-statistics-overview

1. Department of Veterans Affairs : https://www.data.va.gov/,  https://developer.va.gov/
    a. National Cemetery Administration (NCA) : https://gravelocator.cem.va.gov/
    a. VA Office of Inspector General (VAOIG) : https://www.va.gov/oig/publications/default.asp
    a. Office of Policy and Planning (OPP) : https://www.va.gov/HEALTHPOLICYPLANNING/OSPA_prod.asp
    a. Veterans Benefits Administration (VBA) : https://benefits.va.gov/benefits/ 
    a. Veterans Health Administration (VHA) : https://www.publichealth.va.gov/studies-data.asp?_ga=2.43552869.1979850101.1542340457-1023302291.1542340457, https://www.va.gov/health/

1. Statistical Programs of Other Federal Agencies 57
    a. ~~Broadcasting Board of Governors (BBG)~~ 
United States Agency for Global Media (USAGM): https://www.usagm.gov/our-work/strategy-and-results/strategic-priorities/research-reports/
    a. Consumer Product Safety Commission (CPSC) : https://www.cpsc.gov/Recalls/CPSC-Recalls-Application-Program-Interface-API-Information, https://www.cpsc.gov/Newsroom/Downloadable-Data
    a. Corporation for National and Community Service’s (CNCS) : https://www.nationalservice.gov/impact-our-nation/evidence-exchange/basic-search
    a. Environmental Protection Agency (EPA) : https://www.epa.gov/enviro/web-services (loads of APIs)
    a. Equal Employment Opportunity Commission (EEOC) : https://www.eeoc.gov/eeoc/statistics/index.cfm, 
    a. Institute of Museum and Library Services (IMLS) : https://www.imls.gov/research-tools/data-collection
    a. National Aeronautics and Space Administration (NASA) : https://api.nasa.gov/, https://www.nasa.gov/data/
    a. National Science Foundation (NSF) : https://www.nsf.gov/developer/
    a. Office of National Drug Control Policy (ONDCP) : https://www.whitehouse.gov/ondcp/ (I couldn't find any data.)
    a. Small Business Administration (SBA) : https://www.sba.gov/about-sba/sba-performance/open-government/digital-sba/open-data/open-data-sources 
    a. Social Security Administration (SSA) : https://www.ssa.gov/developer/, https://www.ssa.gov/data/ 
    a. U.S. Agency for International Development (USAID) : https://www.usaid.gov/results-and-data/data-resources, https://www.usaid.gov/developer
    
# What did I learn? 

- Just Google "search term" + gov + data + api. You'll probably find what you're looking for. 
- data.gov is not super useful unless you know exactly what you're looking for. There's just too much data! 
- There are a surprising number of federal agencies and/or programs putting their work on Github. Pretty exciting! 
- Get one API key for many .gov APIs: https://api.data.gov/
- The Open Data Executive Order is pretty great: https://obamawhitehouse.archives.gov/the-press-office/2013/05/09/executive-order-making-open-and-machine-readable-new-default-government- 

