# Cypress.io SSL Repro

🔒 Repro for a [Cypress.io](https://www.cypress.io/) `ERR_SSL_VERSION_OR_CIPHER_MISMATCH` issue

![:(](https://user-images.githubusercontent.com/307183/36454900-b312dfbc-1652-11e8-8a10-a7e1b3db0a68.png)

## Running

Simply run `docker-compose up` in the root of this repository. An Nginx server will be launched at [`localhost:8443`](https://localhost:8443).

## Testing

### Passing Tests

The following Cypress test should pass when run. (As in not cause Cypress to display the `ERR_SSL_VERSION_OR_CIPHER_MISMATCH` error)

```js
describe('Passing Tests', function(){
    it('Browse to "localhost" with visit()', function() {
	cy.visit('https://localhost:8443')
    })

    it('Browse to "localhost" with request()', function() {
	cy.request('https://localhost:8443')
    })

    it('Browse to "127.0.0.1" with visit()', function() {
	cy.request('https://127.0.0.1:8443')
    })

    it('Browse to "127.0.0.1" with visit() and get a 403', function() {
	cy.visit('https://127.0.0.1:8443/403')
    })
})
```

### Failing Tests

The following Cypress test should (currently) fail, and cause Cypress to display the `ERR_SSL_VERSION_OR_CIPHER_MISMATCH` error.

```js
describe('Failing Tests', function(){
    it('Browse to "127.0.0.1" with visit()', function() {
	cy.visit('https://127.0.0.1:8443')
    })

    it('Browse to "127.0.0.1" with visit() and get a 200', function() {
	cy.visit('https://127.0.0.1:8443/200')
    })

    it('Browse to "127.0.0.1" with visit() and get a 307', function() {
	cy.visit('https://127.0.0.1:8443/307')
    })
})
```

### Regenerating SSL Certificate

I've committed them for convenience, but if you want to regenerate the SSL certificate, simply run `./make-cert.sh` in the root of this repository.
