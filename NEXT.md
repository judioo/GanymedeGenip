How I would implement the Rest


*Task 2: New class 'GanymedeGenip::Range'.*

instances of GG::Range would require an instance of  a spreadsheet


  $range = GanymedeGenip::Range->new( spreadsheet => GanymedeGenip::Spreadsheet->new, range =>'D1:Z10' );

OR

  $range = GanymedeGenip::Range->new( spreadsheet => $self, range =>'D1:Z10' );

if called within an instance of spreadsheet.


'GanymedeGenip::Range' would iterate over the range (row by row) querying the passed spreadsheet for each cells value the results of which it would store in a hash. For example range 'A1:B1' where there is only 2 columns may give

  'A1' => 10,
  'A2' => '=SUM(B1:B2)'
  'B1' => '89.9'

The result of the new class would probably be that  GanymedeGenip::Spreadsheet::_getRowColFromCellName would need to be made public.

*Task 3: New class 'GanymedeGenip::Formulae'*

It may have subclasses for each calculations 

  GanymedeGenip::Formulae::SUM
  GanymedeGenip::FormulaeCOUNT
  etc

Instances of GG::Formulae would require an instance of  GanymedeGenip::Range.

my $formulae = GanymedeGenip::Formulae->new( range => $range );


A possible method could be displayCalculation

  $result = GanymedeGenip::Formulae->displayCalculation(
    formula = >'=SUM(D1:F1)'
  )

Which selects the correct delegate for the formula which then iterates over the range performing the calculation. Returning the result.


*Task 4: Cells with know how*

The cell would be re-factored to require a formulae delegate.

so creating a cell would look like

GanymedeGenip::Cell->new( formulaDelegate => $formulae, value =>'blah');

Cells display would also need altering as it would need to consider formulae strings and if a match is found delegate the display request. In other words

  if($self->formulaDelegate->isValueAFormula($self->value)) {
    return $self->formulaDelegate->displayFormulae($self->value);
  }

This way the Cell itself need not know a thing about how the calculations are done while also enabling new formulae to be added / removed without changing the Cell code.


There are some really obvious gotchas above... I guess I'll have to explain further :)







