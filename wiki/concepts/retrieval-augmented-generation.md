---
type: concept
title: Retrieval-Augmented Generation
aliases: [RAG]
tags: [llm, retrieval, knowledge-management, inference]
related: [[llm-wiki-pattern]]
created: 2026-05-02
updated: 2026-05-02
---

# Retrieval-Augmented Generation

## What it is
A technique for grounding LLM outputs in external documents at inference time. Documents are chunked and encoded as vector embeddings; at query time, the system retrieves the most semantically similar chunks and provides them as context to the LLM.

## How it works
1. Documents are split into fixed-size chunks (typically 256–1024 tokens with overlap).
2. Each chunk is encoded by an embedding model into a dense vector.
3. Vectors are stored in a vector database (e.g., Pinecone, Weaviate, pgvector).
4. At query time, the query is encoded and the $k$ nearest-neighbour chunks are retrieved by cosine similarity.
5. Retrieved chunks are inserted into the LLM prompt as context.

## Why it matters
Allows LLMs to answer questions grounded in a specific document corpus without fine-tuning. Widely deployed in enterprise search, document Q&A, and chatbots. Systems like NotebookLM, ChatGPT file uploads, and most commercial document AI products use this approach.

## Key variants or extensions
- **Hybrid search**: Combines dense vector retrieval with sparse BM25 keyword search, improving recall on named entities and exact terms.
- **Reranking**: A second-stage model (e.g., a cross-encoder) rescores retrieved chunks for relevance before passing to the LLM.
- **HyDE (Hypothetical Document Embeddings)**: Generates a hypothetical answer, embeds it, and uses that embedding for retrieval — often outperforms query-embedding retrieval.
- **Multi-hop RAG**: Iterative retrieval where the LLM generates sub-queries from initial results to find supporting evidence across multiple chunks.

## Limitations and open questions
- **No accumulation**: Knowledge is re-derived from raw documents on every query. Nothing is synthesised or cross-referenced in advance. Contrast with [[llm-wiki-pattern]], where compilation happens once and persists.
- **Chunk boundary problem**: Semantic units that span chunk boundaries are split, degrading retrieval of information that requires reading across sections.
- **Top-k sufficiency assumption**: Assumes the relevant context falls within the top $k$ results. Multi-hop questions requiring synthesis across many sources are difficult to answer reliably.
- **Embedding model dependency**: Retrieval quality is coupled to the embedding model's semantic space, which may not align with the query domain.
- **Infrastructure cost**: Requires a vector database and embedding pipeline that the [[llm-wiki-pattern]] avoids entirely at moderate scale.

## Key sources
- [[2026-04-karpathy-second-brain-explained]] — Uses RAG as the contrasting baseline to motivate the LLM Wiki pattern
