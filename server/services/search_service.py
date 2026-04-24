from config import Settings
from tavily import TavilyClient
import trafilatura

settings = Settings()

tavily_client = TavilyClient(api_key=settings.TAVILY_API_KEY)

# class SearchService:
#     def web_search(self, query: str):
#         results = []
#         response = tavily_client.search(query,max_results=5)
#         search_results = response.get("results",[])

#         for result in search_results:
#             downloaded = trafilatura.fetch_url(result.get("url"))
#             content = trafilatura.extract(downloaded,include_comments=False)
#             results.append({
#                 "title": result.get("title",""),
#                 "url": result.get("url"),
#                 "content": content,
#             })
        
#         return results

class SearchService:
    def web_search(self, query: str):
        results = []
        response = tavily_client.search(query, max_results=10)  # Fetch 10, keep valid ones
        search_results = response.get("results", [])
        
        for result in search_results:
            if len(results) >= 5:  # Stop once we have 5 valid results
                break
            
            downloaded = trafilatura.fetch_url(result.get("url"))
            content = trafilatura.extract(downloaded, include_comments=False)
            
            if content and len(content.strip()) > 0:
                results.append({
                    "title": result.get("title", ""),
                    "url": result.get("url"),
                    "content": content,
                })
        
        return results