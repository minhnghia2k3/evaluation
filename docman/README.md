## DocMan - Internal Document Management System

### Project Structure
```
docman/
├── cmd/main.go                          # Entry point, routes, server                                                                                                                                     
├── internal/                                                                                                                                                                                              
│   ├── model/model.go                   # Domain entities (Employee, Document, Label, Role, Session)                                                                                                      
│   ├── repository/repository.go         # SQLite DB layer with auto-migration                                                                                                                             
│   ├── middleware/middleware.go          # Auth (session cookie) + RBAC middleware                                                                                                                        
│   └── handler/handler.go              # HTTP handlers for all features                                                                                                                                   
├── templates/                           # Go templates + HTMX                                                                                                                                             
│   ├── base.html                        # Shared head/foot/navbar fragments                                                                                                                               
│   ├── login.html, register.html        # Auth pages                                                                                                                                                      
│   ├── index.html                       # Document listing with filters                                                                                                                                   
│   ├── doc_list_partial.html            # HTMX partial for live search/filter                                                                                                                             
│   ├── doc_form.html                    # Create/Edit document form                                                                                                                                       
│   ├── doc_view.html                    # Document detail + share link                                                                                                                                    
│   └── doc_shared.html                  # Public shared document view                                                                                                                                     
├── uploads/                             # File storage                                                                                                                                                    
├── go.mod, go.sum
```

### Techstack
- **Go 1.25** — Backend language
- **SQLite** — File-based relational database management system
- **HTMX 2.0.4** — Dynamic UI without JavaScript frameworks
- **Go html/template** — Server-side rendering
- **Cookie-based sessions** — Authentication

### Features Implemented
1. **Register/Login** — bcrypt password hashing, cookie-based sessions
2. **RBAC** — 5 roles (admin > manager > qe > engineer > viewer), documents have min_role access level
3. **Document CRUD** — upload files, set title/description/group/labels/access level
4. **Labels & Groups** — comma-separated labels, free-text groups, filter by either
5. **Search** — full-text search on title + description via HTMX
6. **Shareable Links** — each document gets a unique token URL, accessible without login
7. **HTMX** — live search/filter, inline delete without page reload
8. **Pagination** — 20 docs per page with prev/next

### How to Run
```bash
cd docman
go build -o docman ./cmd/main.go                                                                                                                                                                           
./docman
# Open http://localhost:8080
# admin@docman.local/admin123
```


Environment variables: PORT (default 8080), DB_PATH (default docman.db).
