# Script de Web Scraping da base do site da Junta Comercial do Estado do Rio de Janeiro (JUCERJA)

Este script é projetado para realizar a raspagem e análise de dados de consultas da Jucerja. O processo inclui a instalação e carregamento de pacotes necessários, a raspagem de dados de páginas web, a combinação de dataframes e o ajuste do dataframe final para análise.

## Funcionalidade

1. **Função `check.packages`:** Verifica se os pacotes necessários estão instalados e, se não estiverem, instala-os automaticamente. Os pacotes principais utilizados incluem `lubridate`, `rvest`, `janitor`, `tidyverse`, `readxl`, `dplyr`, e `tidyr`.

2. **Carregamento de Dados Suporte:** Carrega planilhas de suporte contendo códigos de consulta e códigos de escritório a partir do arquivo `suporte.xlsx`.

3. **Raspagem de Dados:** Itera sobre diferentes anos, códigos de consulta e códigos de escritório para coletar dados de uma página web específica da Jucerja. Os dados coletados são armazenados em dataframes nomeados dinamicamente.

4. **Combinação e Ajuste de Dataframes:** Une todos os dataframes coletados em um único dataframe e ajusta os dados, incluindo a adição de colunas de descrição e formatação final.

## Dependências

- **R versão 3.6 ou superior**
- **Pacotes:** `lubridate`, `rvest`, `janitor`, `tidyverse`, `readxl`, `dplyr`, `tidyr`

Este script pode ser utilizado como uma base para futuras análises e ajustes conforme necessário. Sinta-se à vontade para modificar e expandir de acordo com suas necessidades específicas.






