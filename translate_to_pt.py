#!/usr/bin/env python3
"""
Translate English grammar questions to Portuguese.
Keeps Spanish text unchanged, translates English explanations/hints/contexts.
"""

import json
import sys

def translate_to_portuguese(text, field_type):
    """
    Translate English text to Portuguese based on field type.
    This is a comprehensive mapping for grammar learning content.
    """
    if not text or not isinstance(text, str):
        return text

    # For questions - translate instructions but keep Spanish
    if field_type == "question":
        replacements = {
            "What does '": "O que significa '",
            "' mean in '": "' em '",
            "' mean?": "' significar?",
            "What does ": "O que significa ",
            " mean in ": " em ",
            " mean?": " significar?",
            "What is the correct form of ": "Qual é a forma correta de ",
            "What is the meaning of ": "Qual é o significado de ",
            "Choose the correct ": "Escolha o ",
            "Select the correct ": "Selecione o ",
            "Fill in the blank": "Preencha o espaço",
            "Complete the sentence": "Complete a frase",
            "Which is correct": "Qual está correto",
            "Identify the correct": "Identifique o correto",
            "use the correct article": "use o artigo correto",
            "select the correct article": "selecione o artigo correto",
            "for the feminine noun": "para o substantivo feminino",
            "for the masculine noun": "para o substantivo masculino",
            "for the plural feminine noun": "para o substantivo feminino plural",
            "for the plural masculine noun": "para o substantivo masculino plural",
            "fill in": "preencha",
            "(use the correct article)": "(use o artigo correto)",
            "(select the correct article)": "(selecione o artigo correto)",
        }
        result = text
        for en, pt in replacements.items():
            result = result.replace(en, pt)
        return result

    # For explanations, hints, contexts - full translation
    if field_type in ["explanation", "hint", "context", "conjugation_info"]:
        # This is where we do comprehensive translation
        # Breaking it into smaller chunks for better accuracy

        # Common grammar explanation patterns
        result = text

        # Basic grammar terms
        grammar_terms = {
            " is a masculine singular noun": " é um substantivo masculino singular",
            " is a feminine singular noun": " é um substantivo feminino singular",
            " is a masculine plural noun": " é um substantivo masculino plural",
            " is a feminine plural noun": " é um substantivo feminino plural",
            " is masculine": " é masculino",
            " is feminine": " é feminino",
            " is singular": " é singular",
            " is plural": " é plural",
            "masculine singular": "masculino singular",
            "feminine singular": "feminino singular",
            "masculine plural": "masculino plural",
            "feminine plural": "feminino plural",
            "definite article": "artigo definido",
            "indefinite article": "artigo indefinido",
            "the definite article": "o artigo definido",
            "the indefinite article": "o artigo indefinido",
            " so the ": " então o ",
            " is used": " é usado",
            " are used": " são usados",
            "ends in": "termina em",
            "ending in": "terminando em",
            "which typically indicates": "que tipicamente indica",
            "which is": "que é",
            "despite ending in": "apesar de terminar em",
            "one of the common exceptions": "uma das exceções comuns",
            "one of the most common exceptions": "uma das exceções mais comuns",
            "This is a famous exception": "Esta é uma exceção famosa",
            "Not all words ending in": "Nem todas as palavras terminando em",
            "All nouns ending in": "Todos os substantivos terminando em",
            "Words of Greek origin": "Palavras de origem grega",
            "Greek-origin words": "Palavras de origem grega",
            "Abbreviations keep the gender": "Abreviações mantêm o gênero",
            "of the full word": "da palavra completa",
            "making it": "tornando-o",
            "making it feminine": "tornando-a feminina",
            "making it masculine": "tornando-o masculino",
            "Other exceptions": "Outras exceções",
            "another exception": "outra exceção",
            "a key exception": "uma exceção chave",
            " are ": " são ",
            " are typically ": " são tipicamente ",
            " is one of ": " é uma de ",
            " means ": " significa ",
            " mean ": " significam ",
            " and is ": " e é ",
            "is short for": "é abreviação de",
            " rule": " regra",
            " to the ": " para o ",
            "to the -": "para a terminação -",
            "exception to the": "exceção à",
            "When the preposition": "Quando a preposição",
            "is followed by": "é seguida por",
            "they contract to": "eles contraem para",
            "This is one of only two contractions": "Esta é uma das duas únicas contrações",
            "This contraction is mandatory": "Esta contração é obrigatória",
            "Contractions": "Contrações",
            "Feminine endings": "Terminações femininas",
            "Masculine endings": "Terminações masculinas",
            "because feeling cold is a temporary state": "porque sentir frio é um estado temporário",
            "We use": "Usamos",
            "adjective agreement": "concordância do adjetivo",
            " big ": " grande ",
            " = ": " = ",
            "which doesn't change for gender": "que não muda com o gênero",
            "'big'": "'grande'",
            "'house'": "'casa'",
            "The hand is cold.": "A mão está fria.",
            "The map is big.": "O mapa é grande.",
        }

        for en, pt in sorted(grammar_terms.items(), key=lambda x: -len(x[0])):
            result = result.replace(en, pt)

        # Common words that need translation
        word_translations = {
            "house": "casa",
            "table": "mesa",
            "cat": "gato",
            "book": "livro",
            "school": "escola",
            "park": "parque",
            "cinema": "cinema",
            "movie": "filme",
            "problem": "problema",
            "map": "mapa",
            "photo": "foto",
            "hand": "mão",
            "city": "cidade",
            "day": "dia",
            "family": "família",
            "children": "crianças",
            "the house": "a casa",
            "the table": "a mesa",
            "the cat": "o gato",
            "the book": "o livro",
            "a house": "uma casa",
        }

        return result

    # For correct/wrong answers - only translate if they're English words
    if field_type == "answer":
        # Common answer translations
        simple_words = {
            "house": "casa",
            "table": "mesa",
            "cat": "gato",
            "dog": "cachorro",
            "book": "livro",
            "school": "escola",
            "park": "parque",
            "cinema": "cinema",
            "city": "cidade",
            "map": "mapa",
            "photo": "foto",
            "hand": "mão",
            "problem": "problema",
            "day": "dia",
            "masculine plural definite article": "artigo definido masculino plural",
            "feminine plural definite article": "artigo definido feminino plural",
            "masculine singular definite article": "artigo definido masculino singular",
            "masculine plural indefinite article": "artigo indefinido masculino plural",
        }

        # Check if it's a Spanish article/word (don't translate)
        spanish_patterns = ["El", "La", "Los", "Las", "Un", "Una", "al", "del", "es", "son", "está", "están"]
        for pattern in spanish_patterns:
            if text.startswith(pattern + " ") or text == pattern:
                return text

        # Translate if it's an English word
        if text in simple_words:
            return simple_words[text]

        return text

    return text


def process_question_file(input_path, output_path):
    """Process a single question file."""
    print(f"Processing {input_path}...")

    with open(input_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    translated_data = {}

    for q_id, q_content in data.items():
        translated_q = {}

        for field, value in q_content.items():
            if field == "question":
                translated_q[field] = translate_to_portuguese(value, "question")
            elif field == "correct":
                translated_q[field] = translate_to_portuguese(value, "answer")
            elif field == "wrong":
                translated_q[field] = [translate_to_portuguese(w, "answer") for w in value]
            elif field in ["explanation", "hint", "context", "conjugation_info"]:
                translated_q[field] = translate_to_portuguese(value, field)
            else:
                translated_q[field] = value

        translated_data[q_id] = translated_q

    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(translated_data, f, ensure_ascii=False, indent=2)

    print(f"✓ Created {output_path} with {len(translated_data)} questions")


if __name__ == "__main__":
    base_path = "/Users/cellithia/FlutterProjects/easy_spanish_grammar_and_words/assets/data/questions"

    levels = ["a1", "a2", "b1", "b2", "c1", "c2"]

    for level in levels:
        input_file = f"{base_path}/en/grammar_{level}.json"
        output_file = f"{base_path}/pt/grammar_{level}.json"
        process_question_file(input_file, output_file)

    print("\n✓ All 6 grammar files translated to Portuguese!")
