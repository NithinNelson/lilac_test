class Video {
  const Video({
    required this.name,
    required this.url,
    required this.thumbnail,
  });

  final String name;
  final String url;
  final String thumbnail;
}

const videos = [
  Video(
    name: "Oppenheimer Trailer",
    url: "https://drive.google.com/uc?export=view&id=1HhiBT_4L010dIRKRPZoUqrGpHP-abX9P",
    thumbnail: "https://images.wallpapersden.com/image/download/oppenheimer-2023-movie-poster_bmVpamqUmZqaraWkpJRmbmdlrWZlbWU.jpg",
  ),
  Video(
    name: "Bekhayali Full Song | Kabir Singh",
    url: "https://drive.google.com/uc?export=view&id=1Wm4WuIUM_V3er3dsaS8fE-NbzGdOdBga",
    thumbnail: "https://i.ytimg.com/vi/VOLKJJvfAbg/maxresdefault.jpg",
  ),
  Video(
    name: "96 Songs | The Life of Ram Video Song",
    url: "https://drive.google.com/uc?export=view&id=1p9GJfbQi4CyHkB26Fis4Y1-O3txgPRsd",
    thumbnail: "https://i.ytimg.com/vi/6LD30ChPsSs/maxresdefault.jpg",
  ),
];
