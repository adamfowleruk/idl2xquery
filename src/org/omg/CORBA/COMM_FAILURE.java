/***** Copyright (c) 1999 Object Management Group. Unlimited rights to 
       duplicate and use this code are hereby granted provided that this 
       copyright notice is included.
*****/

package org.omg.CORBA;

public class COMM_FAILURE extends org.omg.CORBA.SystemException {

  public COMM_FAILURE() {
    super(null, 0, CompletionStatus.COMPLETED_MAYBE);
  }

  public COMM_FAILURE(int minor, CompletionStatus completed) {
    super(null, minor, completed);
  }

  public COMM_FAILURE(String reason) {
    super(reason, 0, CompletionStatus.COMPLETED_MAYBE);
  }

  public COMM_FAILURE(String reason, int minor, CompletionStatus completed) {
    super(reason, minor, completed);
  }

}
