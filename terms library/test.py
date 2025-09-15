# Make sure DAB_TERMS_API is installed and accessible, or adjust the import path if needed
# Example: If DAB_API.py is in the same directory, use:
# from DAB_API import TermsAPI

from DAB_TERMS_API.DAB_API import TermsAPI
import os   

from my_semantic_analyzer.semantic_analyzer import *


token = "blue-cloud-terms-maris-bv"
view = "blue-cloud-terms"
type = "instrument"
max = 20
terms_api = TermsAPI(token=token, view=view)
terms = terms_api.get_terms(type=type, max=max)


"""## Objects"""

analyzer = SemanticAnalyzer()
terms_to_analyze = [term.get_value().replace('(', '').replace(')', '') for term in terms.get_terms()]

print()
print()


match_types = [Matchtype("exactMatch")]
match_properties = [MatchProperty("altLabel"), MatchProperty("prefLabel")]

# Perform the analysis
analysis_results = analyzer.analyzeTerms(terms_to_analyze, match_types, match_properties)

# Process the results
matches = analysis_results.get_matches();
print(f"Number of Matches:", len(matches))

print("Matches found:")
for match in matches:
      print(f"  Matching Term: {match.getMatchingTerm()}")
      print(f"  Match Property: {match.getMatchProperty()}")
      print(f"  Match Type: {match.getMatchType()}")
      print(f"  Term Code: {match.getTermCode()}")
      print(f"  Vocabulary: {match.getVocabulary()}")
      print(f"  Concept URI: {match.getConceptURI()}")
      print("-" * 20)