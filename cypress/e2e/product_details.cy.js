describe('product details', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('navigates from the home page to the product detail page', () => {
    cy.get('.products article')
      .get("[alt='Scented Blade']")
      .click()
      
    cy.get('.product-detail').contains('Scented Blade')
  })
})