Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2649119E11
	for <lists+linux-mmc@lfdr.de>; Fri, 10 May 2019 15:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfEJNYU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 10 May 2019 09:24:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39384 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfEJNYU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 May 2019 09:24:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ADJ05q077231;
        Fri, 10 May 2019 13:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=SGhg8csM+Y98GUzU4SXf1DBvpQaB0NDjiZWAlh6ToH0=;
 b=qoN6tcTigdcAMm3bf2EqtLKucp3vv2pyVQFQ5n1UoA1IMtCHeSA9IoF7kiXM4s2iQX0a
 D+pWVQOZTY2bi6cZqU47pDfY1Q6nAHJtd2OCGNXONJbllcpClhSCbdOkRZEik5MHUaVB
 ILs/F3JMTlfWszV0gJcW+hXquQAoxtYYnM9g0KYoT/cNHcWZdirv0c+aapDukZPRusrC
 e+F2mh1bVbrflr4UUyHiwKnmyn0iVexEaYHhYuG/WEJIiZBcYGIRRIwuw0UVMDxCc0Z7
 oSbOCRhmZRyzs4vtUB4bbqgY8FQOviC4Ck0A7Sp7tpREYpm3y5w8/y+NmU92RzG3lcq+ Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2s94b6h3gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 13:24:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ADNAGw119776;
        Fri, 10 May 2019 13:24:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2scpy68qpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 13:24:00 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4ADNuHE003904;
        Fri, 10 May 2019 13:23:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 May 2019 13:23:55 +0000
Date:   Fri, 10 May 2019 16:23:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     walter harms <wharms@bfs.de>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hannes Reinecke <hare@suse.de>,
        Martin Wilck <martin.wilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mspro_block: Fix an error code in mspro_block_issue_req()
Message-ID: <20190510132347.GH16030@kadam>
References: <20190510112440.GA22858@mwanda>
 <5CD57891.9000505@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CD57891.9000505@bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=651
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100094
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=687 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100094
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, May 10, 2019 at 03:11:45PM +0200, walter harms wrote:
> If i see this correcly everybody leaving the loop making the function return something.
> I do not know how would do that but IMHO is better to be defensive and end the function
> with a propper return code (perhaps 0).
> 

It's a forever loop.  If we add another break statement without adding
at return then GCC will complain.

I feel like maybe you're saying that you don't like forever loops?  That
becomes a pretty complicated position to take...

regards,
dan carpenter

