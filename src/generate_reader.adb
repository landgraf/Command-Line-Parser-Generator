with Ada.Wide_Text_IO;

with Asis.Declarations,
     Asis.Elements,
     Asis.Expressions,
     Asis.Text;

with Thick_Queries;

with Trim;

procedure Generate_Reader (For_Type : in     Asis.Declaration) is
   use Asis.Declarations, Asis.Elements,
       Asis.Expressions, Asis.Text;
   use all type Asis.Definition_Kinds;

   Full_Type  : Asis.Element;
   CU_Of_Type : Asis.Compilation_Unit;
begin
   Full_Type := Corresponding_Name_Declaration
                  (Thick_Queries.Simple_Name (For_Type));
   CU_Of_Type := Enclosing_Compilation_Unit (Full_Type);

   declare
      use Ada.Wide_Text_IO;

      Source_Name : constant Wide_String :=
        Defining_Name_Image (Names (Unit_Declaration (CU_Of_Type)) (1));
      Type_Name   : constant Wide_String :=
        Source_Name & "." & Trim (Element_Image (For_Type));
   begin
      New_Line;
      Put_Line ("----------------------");
      Put_Line ("with Ada.Command_Line,");
      Put_Line ("     Ada.Text_IO;");
      Put_Line ("with " & Source_Name & ";");
      Put_Line ("procedure Reader is");
      Put_Line ("   use Ada.Command_Line, Ada.Text_IO;");
      Put_Line ("   O : constant " & Type_Name & " := " & Type_Name &
                  "'Value (Argument (1));");
      Put_Line ("begin");
      Put_Line ("   Put_Line (""" & Type_Name & ": "" & " & Type_Name &
                  "'Image (O));");
      Put_Line ("end Reader;");
      Put_Line ("----------------------");
   end;
end Generate_Reader;