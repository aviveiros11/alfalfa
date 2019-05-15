# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/reference/measure_writing_guide/

# start the measure
class PowerSensor240 < OpenStudio::Measure::ModelMeasure

  # human readable name
  def name
    return "PowerSensor240"
  end

  # human readable description
  def description
    return "Expose the Electricity:Facility from Output:Meter to be a Haystack tagged point"
  end

  # human readable description of modeling approach
  def modeler_description
    return " The expososure is through multiple EP modules==> EMS:GlobalVariable, EMS:OutputVariable, EMS:Program, EMS:CallingPoints, Output:Variable, Output:Meter  "
  end

  # define the arguments that the user will input
  def arguments(model)
    args = OpenStudio::Measure::OSArgumentVector.new

    # the name of the space to add to the model
    power_exposed = OpenStudio::Measure::OSArgument.makeStringArgument('power_sensor', true)
    power_exposed.setDisplayName('PowerSensor')
    power_exposed.setDescription('ExposePowerSensor.')
    args << power_exposed

    return args
  end

  # define what happens when the measure is run
  def run(model, runner, user_arguments)
    super(model, runner, user_arguments)

    # use the built-in error checking
    #if !runner.validateUserArguments(arguments(model), user_arguments)
    #  return false
    #end

    # assign the user inputs to variables
    #power = runner.getStringArgumentValue("power_sensor", user_arguments)

    # check the space_name for reasonableness
    #if space_name.empty?
    #  runner.registerError("Empty space name was entered.")
    #  return false
    #end

    # report initial condition of model
    runner.registerInitialCondition("i am working to add electricity:facility")

    #add Output:Meter
	electricity_facility = OpenStudio::Model::OutputMeter.new(model)
	electricity_facility.setName("Electricity:Facility")
	electricity_facility.setReportingFrequency("Timestep")

    # add EMS:global
    ems_global_ele = OpenStudio::Model::EnergyManagementSystemGlobalVariable.new(model, "ele")

	
	# add EMS:sensor
	ele_sensor = OpenStudio::Model::EnergyManagementSystemSensor.new(model, "Electricity:Facility")
	ele_sensor.setName("building_electricity_demand_power")
	
	# add EMS:program
	ele_program = OpenStudio::Model::EnergyManagementSystemProgram.new(model)
	ele_program.setName("get_electricity")
	program_body = "set ele=building_electricity_demand_power"
	ele_program.setBody(program_body)
	
	# add EMS-CallingManager
	ele_program_call = OpenStudio::Model::EnergyManagementSystemProgramCallingManager.new(model)
	ele_program_call.addProgram(ele_program)
	ele_program_call.setName('callingpoint_main')
	ele_program_call.setCallingPoint("EndOfSystemTimestepAfterHVACReporting")
	
	# add EMS-Output
	ems_output_ele = OpenStudio::Model::EnergyManagementSystemOutputVariable.new(model, ems_global_ele)
	ems_output_ele.setName("ele_tot")
	ems_output_ele.setEMSVariableName("ele")
	ems_output_ele.setTypeOfDataInVariable("Averaged")
	ems_output_ele.setUpdateFrequency("ZoneTimestep")
	ems_output_ele.setExportToBCVTB(true)

    # add EMS-Output to Output:Variable
	ele_outputvar = OpenStudio::Model::OutputVariable.new("ele_tot", model)
	ele_outputvar.setKeyValue("*")
	#ele_outputvar.setVariableName("ele_tot")
	ele_outputvar.setReportingFrequency("Timestep")


    # echo the new space's name back to the user
    runner.registerInfo("power sensor was added sucessfully!")

    # report final condition of model
    runner.registerFinalCondition(" power sensor are done!")

    return true

  end
  
end

# register the measure to be used by the application
PowerSensor240.new.registerWithApplication
