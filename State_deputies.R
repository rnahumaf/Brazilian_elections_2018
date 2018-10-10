library('rvest')

# Obtain information from candidates to the State Legislative Assemblies in 2018
page=read_html("https://especiais.gazetadopovo.com.br/eleicoes/2018/candidatos/sp/deputado-estadual/")
links <- page %>% html_nodes(".cor-preto") %>% html_attr('href')

length(links)
links[2174] # Last candidate listed in the webpage

df <- matrix(ncol=5)
df <- NULL
for(i in 992:2174){
  print(i)
  candidato=read_html(links[i])
  linha <- candidato %>% 
    html_nodes(".situacao-candidatura strong, 
                        .table-dados-pessoais tr:nth-child(6) td,
                        #cont-left tr:nth-child(6) td,
                        .table-dados-pessoais tr:nth-child(1) td,
                        #cont-left tr:nth-child(2) td") %>%
    html_text()
  df <- rbind(df, linha)
}

print(df)

write.csv(df, "Estaduais.csv")
