javac -classpath "/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS.java

java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y IEEE13.XML ieee13
java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y IEEE13_Assets.XML ieee13assets
java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y IEEE8500u.XML ieee8500u
java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y IEEE8500.XML ieee8500

#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y 4BusYYbal_CDPSM_Combined.XML ieee4yy
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y 4busDYBal_CDPSM_Combined.XML ieee4dy
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y 4busOYODBal_CDPSM_Combined.XML ieee4oyod
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y ieee4OYOD-ubal_CDPSM_Combined.XML ieee4oyodu
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y 4busYDBal_CDPSM_Combined.XML ieee4yd
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y DGProtFdr_CDPSM_Combined.XML ieeeDG
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y IEEE_30_CDPSM_Combined.XML ieee30
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y NEV_CDPSM_Combined.XML ieeeNEV
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y ieee123_CDPSM_Combined.XML ieee123
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y ieee34-2_CDPSM_Combined.XML ieee34
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y ieee37_CDPSM_Combined.XML ieee37
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y IEEE8500_CDPSM_Combined.XML ieee8500
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y ckt5_CDPSM_Combined.XML epri5
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y ckt7_CDPSM_Combined.XML epri7
#java -classpath ".:/Users/mcde601/src/apache-jena-3.1.0/lib/*" CDPSM_to_DSS -e=u -f=60 -v=0.001 -s=0.001 -q=y ckt24_CDPSM_Combined.XML epri24

