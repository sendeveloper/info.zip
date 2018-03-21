      		      <table width="92%" border="0" cellspacing="0" cellpadding="2" align="center">
            		<tr>
                	 <td width= "100%" style="padding:2px; 
                                        font-size:14px; 
                                        font-weight:600;
                                        text-decoration:underline;">Export Options<td>
		            </tr>
        		    <tr>
                	  <td >

                  	   <table style="width: 100%;" cellpadding="2" cellspacing="0" align="center">
                    	<tr>
                            <td>&nbsp;</td>
                            <td colspan="4" class="major-head">Sales Tax</td>
                            <td style="width:50px;">&nbsp;</td>
                            <td colspan="3" class="major-head">Use Tax</td>
                            <td style="width:100px;">&nbsp;</td>            
	                    </tr>
    	                <tr>
                             <td style="text-decoration:underline;width:20%;padding-top:10px;"> Standard Tables  </td>
                             <td class="format-heading">File Count</td>
                             <td class="format-heading">Individual States</td>
                             <td class="format-heading">Entire US</td>
                             <td class="format-heading">NY Clothing</td>
                             <td style="width:10px;">&nbsp;</td> 	
                             <td class="format-heading">File Count</td>
                             <td class="format-heading">Individual States</td>      
                             <td class="format-heading">Entire US</td>
                             <td>&nbsp;</td>
                        </tr>
                        <tr>
                             <td > Basic  </td>
                             <td><span id="spnBasicFileCountSales"></span></td>
                             <td>
                                <input type="button" value="Run" style="width:75px" 
                                    onclick="javascript:RunFunctions('Individual States', 
                                                                    'Basic', 
                                                                    'Sales',this);"	
                                    name="cmdExportSalesStates" 
                                    Id="cmdExportSalesStates"/>
                              </td>
                              <td>
                                 <input type="button" value="Run" style="width:75px"
                                    onclick="javascript:RunFunctions('Entire US', 
                                                                    'Basic', 
                                                                    'Sales');"	
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                              </td>
                              <td>&nbsp;</td>
                              <td style="width:10px;">&nbsp;</td> 	
                              <td><span id="spnBasicFileCountUse"></span></td>                                       															 	                      <td>
                                <input type="button" value="Run" style="width:75px" 
                                    onclick="javascript:RunFunctions('Individual States', 
                                                                    'Basic', 
                                                                    'Use');"	
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>                                             
                              </td>                                             
                              <td>
                                <input type="button" value="Run" style="width:75px" 	
                                            onclick="javascript:RunFunctions('Entire US', 
                                                                    'Basic', 
                                                                    'Use');"	
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                             
                              </td>                                             
                              <td>&nbsp;</td>
                    	</tr>
                    	<tr>
                          <td> Full Breakout </td>
                          <td><span id="spnFullBreakoutFileCountSales"></span></td>
                          <td>
                             <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'FullBreakout', 
                                                                    'Sales');" 
                                        name="cmdExportSalesStates" 
                                        Id="cmdExportSalesStates"/>
                           </td>
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'FullBreakout', 
                                                                    'Sales');" 
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                           </td>
                           <td>                                            	
                            <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('NY Clothing', 
                                                                    'FullBreakout', 
                                                                    'Sales');" 
                                        name="cmdExportSpecial_NY_Clothing" ID="cmdExportSpecial_NY_Clothing"/></td>
                           <td style="width:10px;">&nbsp;</td> 	
                           <td><span id="spnFullBreakoutFileCountUse"></span></td>
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'FullBreakout', 
                                                                    'Use');" 
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>                                             
                           </td>                                             
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'FullBreakout', 
                                                                    'Use');" 
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                             
                           </td>                                                
                           <td>&nbsp;</td>
                    	</tr>
                    	<tr>
                           <td> Unique Zips  </td>
                           <td><span id="spnUniqueZipsFileCountSales"></span></td>
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'UniqueZips', 
                                                                    'Sales');" 
                                        name="cmdExportSalesStates" 
                                        Id="cmdExportSalesStates"/>
                           </td>
                           <td>
                                <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'UniqueZips', 
                                                                    'Sales');" 
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                           </td>
                           <td>&nbsp;</td>
                           <td style="width:10px;">&nbsp;</td> 	
                           <td><span id="spnUniqueZipsFileCountUse"></span></td>                                           
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'UniqueZips', 
                                                                    'Use');" 
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>                                             
                           </td>                                             
                           <td>
                                <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'UniqueZips', 
                                                                    'Use');" 
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                             
                           </td>                                                
                           <td>&nbsp;</td>
                    	</tr>
                    	<tr>
                          <td style="text-decoration:underline;padding-top:20px" colspan="10"> Speciality Tables  </td>
                    	</tr>
						
						<tr>
                           <td> Epicor - Manage2000</td>
                           <td><span id="spnEpicorManage2000FileCountSales"></span></td>
                           <td>
                                <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'EpicorManage2000', 
                                                                    'Sales');" 
                                        name="cmdExportSalesStates" 
                                        Id="cmdExportSalesStates"/>
                           </td>
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'EpicorManage2000', 
                                                                    'Sales');" 
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                           </td>
                           <td>&nbsp;</td>
                           <td style="width:10px;">&nbsp;</td> 	
                           <td>"There is only Sales tax table. </td>                                             
                           <td>Use and Sales tax are combined."</td>                                              
                            <td>&nbsp;</td>
                    	</tr>
						
						<tr>
                           <td> Epicor - Prophet21</td>
                           <td><span id="spnEpicorProphet21FileCountSales"></span></td>
                           <td>
                                <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'EpicorProphet21', 
                                                                    'Sales');" 
                                        name="cmdExportSalesStates" 
                                        Id="cmdExportSalesStates"/>
                           </td>
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'EpicorProphet21', 
                                                                    'Sales');" 
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                           </td>
                           <td>&nbsp;</td>
                           <td style="width:10px;">&nbsp;</td> 	
                           <td><span id="spnEpicorProphet21FileCountUse"></span></td>                                       															                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'EpicorProphet21', 
                                                                    'Use');" 
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>
                           </td>                                             
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'EpicorProphet21', 
                                                                    'Use');" 
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                             
                            </td>                                              
                            <td>&nbsp;</td>
                    	</tr>
						
                    	<tr>
                           <td> Evolution</td>
                           <td><span id="spnEvolutionFileCountSales"></span></td>
                           <td>
                                <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Evolution', 
                                                                    'Sales');" 
                                        name="cmdExportSalesStates" 
                                        Id="cmdExportSalesStates"/>
                           </td>
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'Evolution', 
                                                                    'Sales');" 
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                           </td>
                           <td>&nbsp;</td>
                           <td style="width:10px;">&nbsp;</td> 	
                           <td><span id="spnEvolutionFileCountUse"></span></td>                                       															                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Evolution', 
                                                                    'Use');" 
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>
                           </td>                                             
                           <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'Evolution', 
                                                                    'Use');" 
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                             
                            </td>                                              
                            <td>&nbsp;</td>
                    	</tr>
                    	<tr>
                           
			   <td> FabChoice </td>
                           
			   <td><span id="spnFabChoiceFileCountSales"></span></td>
                           
			   <td>
                                
				<input type="button" value="Run" style="width:75px" 
                                        
					onclick="javascript:RunFunctions('Individual States', 
                                                                    
									'FabChoice',
									'Sales');" 
                                        
					name="cmdExportSalesStates" 
                                        
					Id="cmdExportSalesStates"/>
                           
			   </td>
                           
			   <td>
                                
				<input type="button" value="Run" style="width:75px"
                                        
				onclick="javascript:RunFunctions('Entire US', 
                                                                    
									'FabChoice', 
                                                                    
									'Sales');" 
                                        
					name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                           
			   </td>
                           
			   <td>&nbsp;</td>
                           
			   <td style="width:10px;">&nbsp;</td>      
                           
			   <td><span id="spnFabChoiceFileCountUse"></span></td>
<td>
                                
				<input type="button" value="Run" style="width:75px"
                                        
				onclick="javascript:RunFunctions('Individual States', 
                                                                    
									'FabChoice', 
                                                                    
									'Use');" 
                                        
					name="cmdExportUseStates" id="cmdExportUseStates"/>
                           
			   </td>                                             
                           
			   <td>
                                
				<input type="button" value="Run" style="width:75px"
                                        
				onclick="javascript:RunFunctions('Entire US', 
                                                                    
									'FabChoice', 
                                                                    
									'Use');" 
                                        
					name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                             
                            
			   </td>                                              
                            
			   <td>&nbsp;</td>
                         
			</tr>

			<tr>
                           <td> Magento </td>
                           <td><span id="spnMagentoFileCountSales"></span></td>
                           <td>
                                <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Magento', 
                                                                    'Sales');" 
                                        name="cmdExportSalesStates" 
                                        Id="cmdExportSalesStates"/>
                            </td>
                            <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'Magento', 
                                                                    'Sales');" 
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                            </td>
                            <td>&nbsp;</td>
                            <td style="width:10px;">&nbsp;</td> 	
                            <td><span id="spnMagentoFileCountUse"></span></td>                                       															 											                                            <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Magento', 
                                                                    'Use');" 
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>
                            </td>                                             
                            <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'Magento', 
                                                                    'Use');" 
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                         
                            </td>                                                 
                            <td>&nbsp;</td>
                    	</tr>                                                        
                    	<tr>
                         <td> Magento - Enterprise</td>
                         <td><span id="spnMagentoEnterpriseFileCountSales"></span></td>
                         <td>
                            <input type="button" value="Run" style="width:75px" 
                                    onclick="javascript:RunFunctions('Individual States', 
                                                                    'Magento Enterprise', 
                                                                    'Sales');" 
                                    name="cmdExportSalesStates" 
                                    Id="cmdExportSalesStates"/>
                          </td>
                          <td>
                            <input type="button" value="Run" style="width:75px" 
                                    onclick="javascript:RunFunctions('Entire US', 
                                                                    'Magento Enterprise', 
                                                                    'Sales');" 
                                    name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                          </td>
                          <td>&nbsp;</td>
                          <td style="width:10px;">&nbsp;</td> 	
                          <td><span id="spnMagentoEnterpriseFileCountUse"></span></td>                                       															 						  <td>
                                <input type="button" value="Run" style="width:75px" 
                                    onclick="javascript:RunFunctions('Individual States', 
                                                                    'Magento Enterprise', 
                                                                    'Use');" 
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>
                          </td>                                             
                          <td>
                                <input type="button" value="Run" style="width:75px" 
                                    onclick="javascript:RunFunctions('Entire US', 
                                                                    'Magento Enterprise', 
                                                                    'Use');" 
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                             
                          </td>                                                        
                          <td>&nbsp;</td>
                    	</tr>
                    	<tr>
                         <td> Sedona</td>
                         <td><span id="spnSedonaFileCountSales"></span></td>
                         <td>
                                <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Sedona', 
                                                                    'Sales');" 
                                        name="cmdExportSalesStates" 
                                        Id="cmdExportSalesStates"/>
                          </td>
                          <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'Sedona', 
                                                                    'Sales');" 
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                          </td>
                          <td>&nbsp;</td>
                          <td style="width:10px;">&nbsp;</td> 	
                          <td><span id="spnSedonaFileCountUse"></span></td>                                       															                          <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Sedona', 
                                                                    'Use');" 
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>                                             
                          </td>                                             
                          <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'Sedona', 
                                                                    'Use');" 
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                             
                          </td>                                                
                          <td>&nbsp;</td>
                    	</tr>
                    	<tr>
                         <td> Ultracart</td>
                         <td><span id="spnUltracartFileCountSales"></span></td>
                         <td>
                                <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Ultracart', 
                                                                    'Sales');" 
                                        name="cmdExportSalesStates" 
                                        Id="cmdExportSalesStates"/>
                          </td>
                          <td>
                                <input type="button" value="Run"  style="width:75px" 
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'Ultracart', 
                                                                    'Sales');" 
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                          </td>
                          <td>&nbsp;</td>
                          <td style="width:10px;">&nbsp;</td> 	
                          <td><span id="spnUltracartFileCountUse"></span></td>                                       															 						  <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Ultracart', 
                                                                    'Use');" 
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>                                             
                          </td>                                             
                          <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'Ultracart', 
                                                                    'Use');" 
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                             
                          </td>                                                
                          <td>&nbsp;</td>
                    	</tr>
                    	<tr>
                          <td> Volusion</td>
                          <td><span id="spnVolusionFileCountSales"></span></td>
                          <td>
                                <input type="button" value="Run" style="width:75px" 
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Volusion', 
                                                                    'Sales');" 
                                        name="cmdExportSalesStates"
                                        Id="cmdExportSalesStates"/>
                          </td>
                          <td>
                                <input type="button" value="Run" style="width:75px"
                                    onclick="javascript:RunFunctions('Entire US', 
                                                                    'Volusion', 
                                                                    'Sales');" 
                                        name="cmdExportSalesEntireUS" ID="cmdExportSalesEntireUS"/>
                          </td>
                          <td>&nbsp;</td>
                          <td style="width:10px;">&nbsp;</td> 	
                          <td><span id="spnVolusionFileCountUse"></span></td>                                         
                          <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Individual States', 
                                                                    'Volusion', 
                                                                    'Use');" 
                                        name="cmdExportUseStates" id="cmdExportUseStates"/>                                             
                          </td>                                             
                          <td>
                                <input type="button" value="Run" style="width:75px"
                                        onclick="javascript:RunFunctions('Entire US', 
                                                                    'Volusion', 
                                                                    'Use');" 
                                        name="cmdExportUseEntireUS" id="cmdExportUseEntireUS"/>                                            
                          </td>                                              
                          <td>&nbsp;</td>
                    	</tr>
                    	<tr>
                        	<td colspan="10" style="padding-top:20px;"> 
                            <input type="button" value="Run Them All" style="width:180px"
                                    name="cmdExportAll" id="cmdExportAll" onClick="javascript:RunThemAll();"/>
                        	</td>            
	                    </tr>                                    
                  	</table>
