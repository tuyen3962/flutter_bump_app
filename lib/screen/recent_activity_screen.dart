// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'recent_activity_cubit.dart';
// import 'recent_activity_state.dart';

// class RecentActivityScreen extends StatelessWidget {
//   const RecentActivityScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => RecentActivityCubit()..loadActivities(),
//       child: const RecentActivityView(),
//     );
//   }
// }

// class RecentActivityView extends StatelessWidget {
//   const RecentActivityView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text(
//           'Recent Activity',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: BlocBuilder<RecentActivityCubit, RecentActivityState>(
//         builder: (context, state) {
//           if (state is RecentActivityLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is RecentActivityError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
//                   const SizedBox(height: 16),
//                   Text(state.message, style: const TextStyle(fontSize: 16)),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () =>
//                         context.read<RecentActivityCubit>().loadActivities(),
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (state is RecentActivityLoaded) {
//             return RefreshIndicator(
//               onRefresh: () =>
//                   context.read<RecentActivityCubit>().refreshActivities(),
//               child: Column(
//                 children: [
//                   _buildStatsSection(context, state),
//                   _buildFilterTabs(context, state),
//                   Expanded(
//                     child: _buildActivitiesList(context, state),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return const SizedBox();
//         },
//       ),
//     );
//   }

//   Widget _buildStatsSection(BuildContext context, RecentActivityLoaded state) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.all(20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildStatItem(
//             '${state.stats.processing}',
//             'Processing',
//             Colors.blue[600]!,
//           ),
//           _buildStatItem(
//             '${state.stats.completed}',
//             'Completed',
//             Colors.green[600]!,
//           ),
//           _buildStatItem(
//             '${state.stats.total}',
//             'Total',
//             Colors.grey[700]!,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatItem(String value, String label, Color color) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey[600],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFilterTabs(BuildContext context, RecentActivityLoaded state) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: Row(
//         children: [
//           _buildFilterTab(
//             context,
//             'All',
//             ActivityFilter.all,
//             state.currentFilter == ActivityFilter.all,
//           ),
//           const SizedBox(width: 12),
//           _buildFilterTab(
//             context,
//             'Processing',
//             ActivityFilter.processing,
//             state.currentFilter == ActivityFilter.processing,
//           ),
//           const SizedBox(width: 12),
//           _buildFilterTab(
//             context,
//             'Completed',
//             ActivityFilter.completed,
//             state.currentFilter == ActivityFilter.completed,
//           ),
//           const SizedBox(width: 12),
//           _buildFilterTab(
//             context,
//             'Failed',
//             ActivityFilter.failed,
//             state.currentFilter == ActivityFilter.failed,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterTab(
//     BuildContext context,
//     String label,
//     ActivityFilter filter,
//     bool isSelected,
//   ) {
//     return GestureDetector(
//       onTap: () => context.read<RecentActivityCubit>().applyFilter(filter),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.black : Colors.grey[100],
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.grey[700],
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildActivitiesList(
//       BuildContext context, RecentActivityLoaded state) {
//     if (state.filteredActivities.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.history, size: 64, color: Colors.grey[400]),
//             const SizedBox(height: 16),
//             Text(
//               'No activities found',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Your processing activities will appear here.',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[500],
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(20),
//       itemCount: state.filteredActivities.length,
//       itemBuilder: (context, index) {
//         final activity = state.filteredActivities[index];
//         final isUpdating = state is RecentActivityUpdating &&
//             state.updatingItemId == activity.id;

//         return _buildActivityCard(context, activity, isUpdating);
//       },
//     );
//   }

//   Widget _buildActivityCard(
//     BuildContext context,
//     ActivityItem activity,
//     bool isUpdating,
//   ) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           _buildActivityIcon(activity),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   activity.title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   activity.timeAgo,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 _buildStatusSection(context, activity, isUpdating),
//               ],
//             ),
//           ),
//           _buildActionButton(context, activity),
//         ],
//       ),
//     );
//   }

//   Widget _buildActivityIcon(ActivityItem activity) {
//     return Container(
//       width: 48,
//       height: 48,
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Stack(
//         children: [
//           Center(
//             child: Text(
//               'IMG',
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 4,
//             right: 4,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(2),
//               ),
//               child: Text(
//                 activity.duration,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 10,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatusSection(
//       BuildContext context, ActivityItem activity, bool isUpdating) {
//     if (isUpdating) {
//       return Row(
//         children: [
//           SizedBox(
//             width: 16,
//             height: 16,
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//               color: Colors.blue[600],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text(
//             'Updating...',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.blue[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: activity.statusColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 activity.statusDisplayText,
//                 style: TextStyle(
//                   color: activity.statusColor,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         if (activity.status == ActivityStatus.processing &&
//             activity.progress != null) ...[
//           const SizedBox(height: 8),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: LinearProgressIndicator(
//               value: activity.progress,
//               backgroundColor: Colors.grey[200],
//               valueColor: AlwaysStoppedAnimation<Color>(activity.statusColor),
//               minHeight: 4,
//             ),
//           ),
//         ],
//         if (activity.status == ActivityStatus.failed &&
//             activity.errorMessage != null) ...[
//           const SizedBox(height: 4),
//           Text(
//             activity.errorMessage!,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.red[600],
//               fontStyle: FontStyle.italic,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _buildActionButton(BuildContext context, ActivityItem activity) {
//     switch (activity.status) {
//       case ActivityStatus.completed:
//         return IconButton(
//           onPressed: () => context
//               .read<RecentActivityCubit>()
//               .openCompletedActivity(activity.id),
//           icon: Icon(Icons.open_in_new, color: Colors.green[600]),
//           tooltip: 'Open',
//         );

//       case ActivityStatus.failed:
//         return PopupMenuButton<String>(
//           icon: Icon(Icons.more_vert, color: Colors.grey[600]),
//           onSelected: (value) {
//             switch (value) {
//               case 'retry':
//                 context.read<RecentActivityCubit>().retryActivity(activity.id);
//                 break;
//               case 'delete':
//                 _showDeleteConfirmation(context, activity.id, activity.title);
//                 break;
//               case 'details':
//                 context
//                     .read<RecentActivityCubit>()
//                     .viewActivityDetails(activity.id);
//                 break;
//             }
//           },
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               value: 'retry',
//               child: Row(
//                 children: [
//                   Icon(Icons.refresh, color: Colors.blue[600]),
//                   const SizedBox(width: 8),
//                   const Text('Retry'),
//                 ],
//               ),
//             ),
//             const PopupMenuItem(
//               value: 'details',
//               child: Row(
//                 children: [
//                   Icon(Icons.info_outline),
//                   SizedBox(width: 8),
//                   Text('Details'),
//                 ],
//               ),
//             ),
//             const PopupMenuItem(
//               value: 'delete',
//               child: Row(
//                 children: [
//                   Icon(Icons.delete, color: Colors.red),
//                   SizedBox(width: 8),
//                   Text('Delete', style: TextStyle(color: Colors.red)),
//                 ],
//               ),
//             ),
//           ],
//         );

//       case ActivityStatus.processing:
//         return PopupMenuButton<String>(
//           icon: Icon(Icons.more_vert, color: Colors.grey[600]),
//           onSelected: (value) {
//             switch (value) {
//               case 'cancel':
//                 _showCancelConfirmation(context, activity.id, activity.title);
//                 break;
//               case 'details':
//                 context
//                     .read<RecentActivityCubit>()
//                     .viewActivityDetails(activity.id);
//                 break;
//             }
//           },
//           itemBuilder: (context) => [
//             const PopupMenuItem(
//               value: 'details',
//               child: Row(
//                 children: [
//                   Icon(Icons.info_outline),
//                   SizedBox(width: 8),
//                   Text('Details'),
//                 ],
//               ),
//             ),
//             const PopupMenuItem(
//               value: 'cancel',
//               child: Row(
//                 children: [
//                   Icon(Icons.cancel, color: Colors.red),
//                   SizedBox(width: 8),
//                   Text('Cancel', style: TextStyle(color: Colors.red)),
//                 ],
//               ),
//             ),
//           ],
//         );

//       case ActivityStatus.queued:
//         return PopupMenuButton<String>(
//           icon: Icon(Icons.more_vert, color: Colors.grey[600]),
//           onSelected: (value) {
//             switch (value) {
//               case 'cancel':
//                 _showCancelConfirmation(context, activity.id, activity.title);
//                 break;
//               case 'details':
//                 context
//                     .read<RecentActivityCubit>()
//                     .viewActivityDetails(activity.id);
//                 break;
//             }
//           },
//           itemBuilder: (context) => [
//             const PopupMenuItem(
//               value: 'details',
//               child: Row(
//                 children: [
//                   Icon(Icons.info_outline),
//                   SizedBox(width: 8),
//                   Text('Details'),
//                 ],
//               ),
//             ),
//             const PopupMenuItem(
//               value: 'cancel',
//               child: Row(
//                 children: [
//                   Icon(Icons.cancel, color: Colors.red),
//                   SizedBox(width: 8),
//                   Text('Cancel', style: TextStyle(color: Colors.red)),
//                 ],
//               ),
//             ),
//           ],
//         );
//     }
//   }

//   void _showDeleteConfirmation(
//       BuildContext context, String activityId, String title) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Delete Activity'),
//         content: Text(
//             'Are you sure you want to delete "$title"? This action cannot be undone.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               context.read<RecentActivityCubit>().deleteActivity(activityId);
//             },
//             child: const Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showCancelConfirmation(
//       BuildContext context, String activityId, String title) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Cancel Processing'),
//         content: Text('Are you sure you want to cancel processing "$title"?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               context.read<RecentActivityCubit>().cancelActivity(activityId);
//             },
//             child:
//                 const Text('Yes, Cancel', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }
