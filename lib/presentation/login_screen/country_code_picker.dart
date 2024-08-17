part of 'login_screen.dart';



Widget _buildCountryCodePicker(BuildContext context, TextEditingController countryCodeController, String countryCodePhone) {
  return InkWell(
    onTap: () async{
      await context.read<CountryCodeCubit>().fetchCountryCodes();
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<CountryCodeCubit, List<CountryCode>>(
            builder: (context, countryCodes) {
              if (countryCodes.isEmpty) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Search by country name',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (query){
                          context.read<CountryCodeCubit>().filterCountryCodes(query);
                        },
                      ),
                    ),
                    Expanded(child: Center(child: CircularProgressIndicator())),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Search by country name',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (query)async{
                            await context.read<CountryCodeCubit>().filterCountryCodes(query);
                          },
                        ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: countryCodes.length,
                        itemBuilder: (context, index) {
                          final countryCode = countryCodes[index];
                          return InkWell(
                            onTap: () {
                              countryCodeController.text = "${countryCode.code} ${countryCode.dialCode}";
                              countryCodePhone = countryCode.dialCode;
                              Navigator.pop(context);
                            },
                            child: ListTile(
                              title: Text(countryCode.name),
                              trailing: Text(
                                '${countryCode.code}  ${countryCode.dialCode}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      );
    },
    child: Container(
      width: 110,
      child: AbsorbPointer(
        child: TextFormField(
          validator: (phone) =>
          phone == null
              ? 'Invalid number format'
              : null,
          controller: countryCodeController,
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 28,
              color: Colors.black38,
            ),
          ),
        ),
      ),
    ),
  );
}