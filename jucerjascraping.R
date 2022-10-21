
################################# VERIFICA CARREGA E INSTALA PACOTES ##############################################################

check.packages <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}


pacotes <-c("lubridate", "rvest", "janitor", "tidyverse", "readxl", "dplyr", "tidyr")

check.packages(pacotes)

################################# cARREGA COMPLEMENTOS NECESSÁRIOS ################################################################
rm(list=ls())
ano <- year(Sys.time())
codesc <- read_xlsx("cod_jucerja.xlsx", sheet = 1)  
codcons <- read_xlsx("cod_jucerja.xlsx", sheet = 2)

################################# RASPAGEM DE DADOS COM REPETIDORES ###############################################################


for (i in 2001:ano){
for (j in codcons$cod_consulta){
for (k in codesc$cod_escritorio){

k <-  formatC(k, width=2, format="d", flag="0")    


link <- paste0("https://www.jucerja.rj.gov.br/Informacoes/EstatisticaSimples?AnoBaseConsulta=",i,"&TipoDeConsulta=",j,"&CodigoEscritorio=",k,"")   
 
element <- paste0("//*[@id='body']/div[1]/div[4]/div/section/div[2]/div/table")
pg <- rvest::read_html(link)   
   
dados <- pg %>%
  rvest::html_nodes(xpath = element) %>%
  rvest::html_table()    
    
dados["ano"] <- i
dados["cod_consulta"] <- j
dados["cod_escritorio"] <- k

rename <- paste0(i,"_",j,"_",k,"")

assign(paste0("df",rename), as.data.frame(dados))


}
 }
  }


################################# UNINDO DATAFRAMES ################################################################

rm(dados,pg,codesc,codcons, ano, element, i, j, k, link, rename)

dff <- sapply(.GlobalEnv, is.data.frame)
dff <- as.data.frame(do.call(rbind, mget(names(dff))))



################################# AJUSTANDO DATAFRAME FINAL ################################################################

codesc <- read_xlsx("cod_jucerja.xlsx", sheet = 1)  
codcons <- read_xlsx("cod_jucerja.xlsx", sheet = 2)
dat <- read_xlsx("cod_jucerja.xlsx", sheet = 3)

dff <- left_join(dff, codcons %>% select(cod_consulta, consulta))

num <- as.numeric(as.character(dff$cod_escritorio))
dff$cod_escritorio<-num

dff <- left_join(dff, codesc %>% select(cod_escritorio, escritorio))

r <- with(dff, which(dff$Var.1=="Total", arr.ind=TRUE))
dff <- dff[-r, ]

dff <- dff %>% 
  pivot_longer(
    cols = Requerimento.de.empresário:Empresário.Individual.com.Responsabilidade.Limitada,
    names_to = "variável",
    values_to = "valor")



dff <- left_join(dff, dat %>% select(Var.1, data))

dff["competencia"] <- paste(dff$data, dff$ano, sep = "")

dff <- dff %>% mutate(Total = NULL, Var.1 = NULL, data=NULL,  ano = NULL)

sub <- gsub("."," ",dff$variável, fixed=TRUE) 

dff$variável <- sub

dff <- select(dff, competencia, cod_consulta, cod_escritorio, everything())

dff$competencia <- as.Date(dff$competencia, format =  "%d/%m/%Y")


str(dff)





