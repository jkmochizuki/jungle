describe('add to cart', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('displays product items by default', () => {
    cy.get('.products article').should('be.visible')
  })

  it("shows 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('initially contains 0 products in the cart', () => {
    cy.get('.nav-link').contains('0')
  })

  it('changes the count of the cart when adding products to it', () => {
    cy.get('.products article')
      .first()
      .contains('Add')
      .click({ force: true })
      
    cy.get('.nav-link').contains('1')
  })
})