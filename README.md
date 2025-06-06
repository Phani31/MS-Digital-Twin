# AI Operating Officer System

A production-grade AI system with Microsoft Teams integration that acts as a digital twin for CEO, CTO, CISO, and Product Head roles.

## Features

- **Multi-Role Support**:
  - CEO: Strategic leadership and organizational transformation (Satya Nadella style)
  - CTO: Technical leadership and architecture guidance
  - CISO: Security and compliance expertise
  - Product Head: Product strategy and roadmap planning

- **Smart Interactions**:
  - Natural language processing
  - Role-based response routing
  - Context-aware responses
  - Response quality evaluation

- **Leadership Styles**:
  - Growth mindset and empathy-driven leadership
  - Innovation with purpose
  - Stakeholder capitalism
  - Digital transformation focus

- **Microsoft Teams Integration**:
  - Real-time bot interactions
  - Rich adaptive cards
  - Typing indicators
  - Error handling

- **Knowledge Management**:
  - Vector store using ChromaDB
  - Multi-format content processing
  - Automated content updates
  - Response caching

## Architecture

- **Core Components**:
  - Teams Bot Server
  - Vector Store
  - Content Processors
  - Role-specific Agents
  - Response Evaluator

- **Security Features**:
  - Rate limiting
  - Input validation
  - Security headers
  - Error handling

- **Performance Optimizations**:
  - Redis caching
  - Connection pooling
  - Async processing

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Zeta-DevX/Ramki-Digital-Twin.git
   cd Ramki-Digital-Twin
   ```

2. Create and activate virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Set up environment variables:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

5. Initialize the system:
   ```bash
   python scripts/init_knowledge_base.py
   ```

6. Start the Teams bot:
   ```bash
   python scripts/run_teams_bot.py
   ```

## Configuration

Required environment variables:
- `MICROSOFT_APP_ID`: Teams bot app ID
- `MICROSOFT_APP_PASSWORD`: Teams bot password
- `MICROSOFT_TENANT_ID`: Azure tenant ID
- `VECTORSTORE_DIR`: Vector store directory
- `COLLECTION_NAME`: Knowledge base collection name

## Testing

Run tests with pytest:
```bash
pytest tests/
```

## Monitoring

The system includes:
- Comprehensive logging
- Performance metrics
- Response quality evaluation
- Cache statistics

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 