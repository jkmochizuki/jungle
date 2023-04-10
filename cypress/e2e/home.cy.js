describe('visits homepage app', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('displays product items by default', () => {
    cy.get('.products article').should('be.visible')
  })

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
})