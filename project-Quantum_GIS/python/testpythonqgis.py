"""
This is a Python class example to run inside the Python console.
"""

import psycopg2, psycopg2.extensions
from PyQt4.QtCore import QSize, QStringList, QString
from PyQt4.QtGui import QImage, QColor, QPainter
from qgis.core import QgsMapRenderer

class Loader:
	def __init__(self, qgis, host, port, user, dbname, dbpass):
		"""
		Pass always the iface as a parameter for the class.
n		"""
		self.qgis = qgis
		self.host = host
		self.port = port
		self.user = user
		self.dbname = dbname
		self.dbpass = dbpass

	def loadSpecies(self):
		"""
		Load species layers.
		"""
		# TOC group creation
		li = self.qgis.utils.iface.legendInterface()
		group = li.addGroup("Species", False)

		uri = self.qgis.core.QgsDataSourceURI()
		uri.setConnection(self.host, self.port, self.dbname, self.user, self.dbpass)
		
		psycopg2.extensions.register_type(psycopg2.extensions.UNICODE)
		psycopg2.extensions.register_type(psycopg2.extensions.UNICODEARRAY)

		connString = "user=racspa host=localhost dbname=racspa port=5432"
		conn = psycopg2.connect(connString)
		conn.set_client_encoding('UTF8')

		cur = conn.cursor()
		cur.execute("select * from data.species;")

		for t in cur.fetchall():
			uri.setDataSource("grid_analysis", "grid_species_"+str(t[0]), "geom", "", "gid")
			vlayer = self.qgis.core.QgsVectorLayer(uri.uri(), t[1], "postgres")
			li.moveLayer(vlayer, group)
			vlayer.loadNamedStyle("/home/git/rac-spa/project-Quantum_GIS/styles/abundance.qml")
			self.qgis.core.QgsMapLayerRegistry.instance().addMapLayer(vlayer)
			
		cur.close()
		conn.close()

	def unloadSpecies(self):
		"""Unload species layers.
		TODO: Finish group removal. It seems not to work."""

		# TOC group creation
		li = self.qgis.utils.iface.legendInterface()
		g = li.groups()
		s = QString('Species')
		
		print(g.indexOf(s))

		for a in g:
			print a
		
		# group = li.removeGroup(g.indexOf(s))
		group = li.removeGroup(0)
		
		psycopg2.extensions.register_type(psycopg2.extensions.UNICODE)
		psycopg2.extensions.register_type(psycopg2.extensions.UNICODEARRAY)

		connString = "user=racspa host=localhost dbname=racspa port=5432"
		conn = psycopg2.connect(connString)
		conn.set_client_encoding('UTF8')

		cur = conn.cursor()
		cur.execute("select * from data.species limit 5;")

		for t in cur.fetchall():
			print(t[1])
			
		cur.close()
		conn.close()

	def loadCommunities(self):
		"""
		Load communities layers.
		"""
		# TOC group creation
		li = self.qgis.utils.iface.legendInterface()
		group = li.addGroup("Communities", False)

		uri = self.qgis.core.QgsDataSourceURI()
		uri.setConnection(self.host, self.port, self.dbname, self.user, self.dbpass)
		
		psycopg2.extensions.register_type(psycopg2.extensions.UNICODE)
		psycopg2.extensions.register_type(psycopg2.extensions.UNICODEARRAY)

		connString = "user=racspa host=localhost dbname=racspa port=5432"
		conn = psycopg2.connect(connString)
		conn.set_client_encoding('UTF8')

		cur = conn.cursor()
		cur.execute("select * from data.community;")

		for t in cur.fetchall():
			uri.setDataSource("grid_analysis", "grid_communities_"+str(t[0]), "geom", "", "gid")
			vlayer = self.qgis.core.QgsVectorLayer(uri.uri(), t[1], "postgres")
			li.moveLayer(vlayer, group) # Doesn't work
			vlayer.loadNamedStyle("/home/git/rac-spa/project-Quantum_GIS/styles/communities.qml")
			self.qgis.core.QgsMapLayerRegistry.instance().addMapLayer(vlayer)
			
		cur.close()
		conn.close()

	def exportImages(self):
		"""Export images."""
		img = QImage(QSize(1000, 800), QImage.Format_ARGB32_Premultiplied)

		color = QColor(255,255,255)
		img.fill(color.rgb())

		p = QPainter()
		p.begin(img)
		p.setRenderHint(QPainter.Antialiasing)

		render = QgsMapRenderer()
