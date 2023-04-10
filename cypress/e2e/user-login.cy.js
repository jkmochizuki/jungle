describe('user login', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('registers a new user', () => {
    cy.contains('.nav-item', 'Register').click()

    cy.get("[id=user_name]").type("John Smith");
    cy.get("[id=user_email]").type('test@test.com');
    cy.get("[id=user_password]").type('123456');
    cy.get("[id=user_password_confirmation]").type('123456');
    cy.contains('Submit').click();
    cy.contains('.nav-item', 'Logout').click()
  })

  it('logs in with an existing user\'credentials', () => {
    cy.contains('.nav-item', 'Login').click()
    
    cy.get("[id=email]").type('test@test.com');
    cy.get("[id=password]").type('123456');
    cy.contains('Submit').click()
    cy.contains('.navbar', 'John Smith')
  })
})