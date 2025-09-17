import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bump_app/base/widget/base_page.dart';
import 'package:flutter_bump_app/base/widget/cubit/base_bloc_provider.dart';
import 'package:flutter_bump_app/config/theme/style/style_theme.dart';
import 'package:flutter_bump_app/screen/create_highlight/create_highlight_cubit.dart';

import 'create_highlight_state.dart';

@RoutePage()
class CreateHighlightPage
    extends BaseBlocProvider<CreateHighlightState, CreateHighlightCubit> {
  const CreateHighlightPage({super.key});

  @override
  Widget buildPage() {
    return const CreateHighlightScreen();
  }

  @override
  CreateHighlightCubit createCubit() {
    return CreateHighlightCubit();
  }
}

class CreateHighlightScreen extends StatefulWidget {
  const CreateHighlightScreen({super.key});

  @override
  State<CreateHighlightScreen> createState() => CreateHighlightScreenState();
}

class CreateHighlightScreenState extends BaseBlocPageState<
    CreateHighlightScreen, CreateHighlightState, CreateHighlightCubit> {
  @override
  void initState() {
    super.initState();
    // Add your initialization logic here
  }

  @override
  String get title => 'Create Highlight';

  @override
  Widget buildBody(BuildContext context, CreateHighlightCubit cubit) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoSection(context, cubit.state),
            _buildActionButtons(context, cubit.state),
            // _buildVideoLibrarySection(context, cubit.state),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, CreateHighlightState state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              children: [
                const TextSpan(
                  text: 'Supported formats: ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                // TextSpan(
                //   text: state.uploadConfig.supportedFormats.map((format) => format.name)
                //       .map((format) => format.name)
                //       .join(', '),
                //   style: TextStyle(color: Colors.blue[600]),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              children: [
                const TextSpan(
                  text: 'Maximum file size: ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                // TextSpan(
                //   text: state.uploadConfig.maxFileSizeFormatted,
                //   style: TextStyle(color: Colors.blue[600]),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, CreateHighlightState state) {
    // if (state is CreateHighlightRecording) {
    //   return _buildRecordingSection(context, state);
    // }

    // if (state is CreateHighlightUploading) {
    //   return _buildUploadingSection(context, state);
    // }

    // if (state is CreateHighlightVideoSelected) {
    //   return _buildSelectedVideoSection(context, state);
    // }

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              context,
              'Record',
              Icons.videocam,
              Colors.blue[600]!,
              () {},
              // () => context.read<CreateHighlightCubit>().startRecording(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              context,
              'Upload',
              Icons.upload,
              Colors.green[600]!,
              // () => context.read<CreateHighlightCubit>().uploadFile(),
              () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );
  }

  Widget _buildRecordingSection(
      BuildContext context, CreateHighlightState state) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Column(
              children: [
                Icon(Icons.fiber_manual_record,
                    size: 48, color: Colors.red[600]),
                const SizedBox(height: 16),
                const Text(
                  'Recording...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatDuration(Duration(seconds: 10)),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[600],
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              // onPressed: () =>
              //     context.read<CreateHighlightCubit>().stopRecording(),
              icon: const Icon(Icons.stop, color: Colors.white),
              label: const Text(
                'Stop Recording',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadingSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              children: [
                Icon(Icons.cloud_upload, size: 48, color: Colors.blue[600]),
                const SizedBox(height: 16),
                const Text(
                  'Uploading...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'fileName',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(0.5 * 100).round()}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              // onPressed: () =>
              // context.read<CreateHighlightCubit>().cancelUpload(),
              icon: Icon(Icons.cancel, color: Colors.red[600]),
              label: Text(
                'Cancel Upload',
                style: TextStyle(
                  color: Colors.red[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: Colors.red[600]!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildSelectedVideoSection(
  //     BuildContext context, CreateHighlightVideoSelected state) {
  //   final selectedVideo = state.videoLibrary
  //       .firstWhere((video) => video.id == state.selectedVideoId);

  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             color: Colors.green[50],
  //             borderRadius: BorderRadius.circular(16),
  //             border: Border.all(color: Colors.green[200]!),
  //           ),
  //           child: Row(
  //             children: [
  //               Container(
  //                 width: 60,
  //                 height: 60,
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[300],
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: const Icon(Icons.play_arrow, size: 24),
  //               ),
  //               const SizedBox(width: 16),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       selectedVideo.title,
  //                       style: const TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                     const SizedBox(height: 4),
  //                     Text(
  //                       '${selectedVideo.duration} • ${selectedVideo.fileSizeFormatted}',
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         color: Colors.grey[600],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Icon(Icons.check_circle, color: Colors.green[600], size: 24),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 20),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: OutlinedButton(
  //                 onPressed: () {},
  //                 // onPressed: () =>
  //                     // context.read<CreateHighlightCubit>().deselectVideo(),
  //                 child: const Text('Cancel'),
  //                 style: OutlinedButton.styleFrom(
  //                   padding: const EdgeInsets.symmetric(vertical: 16),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(width: 16),
  //             Expanded(
  //               child: ElevatedButton(
  //                 onPressed: () => context
  //                     // .read<CreateHighlightCubit>()
  //                     // .createHighlightFromSelected(),
  //                 child: const Text(
  //                   'Create Highlight',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.green[600],
  //                   padding: const EdgeInsets.symmetric(vertical: 16),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildVideoLibrarySection(
  //     BuildContext context, CreateHighlightLoaded state) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  //         child: Text(
  //           'Your Video Library',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w600,
  //             color: Colors.black87,
  //           ),
  //         ),
  //       ),
  //       if (state.videoLibrary.isEmpty)
  //         Padding(
  //           padding: const EdgeInsets.all(40),
  //           child: Center(
  //             child: Column(
  //               children: [
  //                 Icon(Icons.video_library_outlined,
  //                     size: 64, color: Colors.grey[400]),
  //                 const SizedBox(height: 16),
  //                 Text(
  //                   'No videos in library',
  //                   style: TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.grey[600],
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Text(
  //                   'Record or upload your first video!',
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Colors.grey[500],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       else
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: GridView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2,
  //               crossAxisSpacing: 16,
  //               mainAxisSpacing: 16,
  //               childAspectRatio: 16 / 12,
  //             ),
  //             itemCount: 10,
  //             itemBuilder: (context, index) {
  //               // final video = state.videoLibrary[index];
  //               // final isSelected = state is CreateHighlightVideoSelected &&
  //               //     state.selectedVideoId == video.id;

  //               return _buildVideoLibraryItem(context, false);
  //             },
  //           ),
  //         ),
  //       const SizedBox(height: 20),
  //     ],
  //   );
  // }

  Widget _buildVideoLibraryItem(
    BuildContext context,
    // VideoLibraryItem video,
    bool isSelected,
  ) {
    return GestureDetector(
      // onTap: () =>
      //     context.read<CreateHighlightCubit>().selectVideoFromLibrary(video.id),
      // onLongPress: () => _showVideoOptions(context, video),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.green[600]!, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        // image: DecorationImage(
                        //   image: NetworkImage(video.thumbnailUrl),
                        //   fit: BoxFit.cover,
                        //   onError: (_, __) {},
                        // ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'duration',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    if (isSelected)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.green[600],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: Text(
                  'title',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _showVideoOptions(BuildContext context, VideoLibraryItem video) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         ListTile(
  //           leading: const Icon(Icons.info),
  //           title: const Text('Video Info'),
  //           onTap: () {
  //             Navigator.pop(context);
  //             _showVideoInfo(context, video);
  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.delete, color: Colors.red[600]),
  //           title: Text('Delete', style: TextStyle(color: Colors.red[600])),
  //           onTap: () {
  //             Navigator.pop(context);
  //             _showDeleteConfirmation(context, video);
  //           },
  //         ),
  //         const SizedBox(height: 16),
  //       ],
  //     ),
  //   );
  // }

  // void _showVideoInfo(BuildContext context, VideoLibraryItem video) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Video Information'),
  //       content: Column(
  //         crossAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Title: ${video.title}'),
  //           const SizedBox(height: 8),
  //           Text('Duration: ${video.duration}'),
  //           const SizedBox(height: 8),
  //           Text('Size: ${video.fileSizeFormatted}'),
  //           const SizedBox(height: 8),
  //           Text('Created: ${_formatDate(video.createdAt)}'),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Close'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _showDeleteConfirmation(BuildContext context, VideoLibraryItem video) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Delete Video'),
  //       content: Text(
  //           'Are you sure you want to delete "${video.title}"? This action cannot be undone.'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             // context
  //             //     .read<CreateHighlightCubit>()
  //             //     .deleteVideoFromLibrary(video.id);
  //           },
  //           child: const Text('Delete', style: TextStyle(color: Colors.red)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
