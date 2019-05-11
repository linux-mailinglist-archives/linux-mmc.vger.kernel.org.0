Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F2C1A74A
	for <lists+linux-mmc@lfdr.de>; Sat, 11 May 2019 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfEKJhV (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 11 May 2019 05:37:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEKJhV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 May 2019 05:37:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4B9U200134178;
        Sat, 11 May 2019 09:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=1sSyjG1UHkf4BGaOevG5w41Ncg19JwlhgkXOf02AopQ=;
 b=DC0BqHMJK6scXHybhPC12M/cpYTtDC8OXCQhgryfop+1VE43/aoWmc/FA6OgGlAntqdB
 TK7UyQyyhy5B5DjCTycs/Gc7LnUSr2P7fzbglUH4Et0bu/ahmaMvab9SHLMhoaLX0iON
 N+aG41MOz7iygeEfxudsESB2/3GKaDIzXAsR7Nt0T42PgSEKoSGoTHyirdRz4e9lKCgX
 iCgNfo4jfKa9uNM1jd7Zozbd0TqPhvBZck4Nq16ol2XS6bBWiJ+iHJtvpiLRXZlFD8aT
 6l2RBWhEcJpF6loMU9LDidkZ2zUMCyceGdttNKBppmWroxL39J7Kilgi75X85hv+WuIE dQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sdntt8q7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 May 2019 09:37:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4B9ZI4Y113369;
        Sat, 11 May 2019 09:37:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2sdme9v355-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 May 2019 09:37:01 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4B9auqc016242;
        Sat, 11 May 2019 09:36:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 11 May 2019 02:36:56 -0700
Date:   Sat, 11 May 2019 12:36:48 +0300
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
Message-ID: <20190511093648.GF18105@kadam>
References: <20190510112440.GA22858@mwanda>
 <5CD57891.9000505@bfs.de>
 <20190510132347.GH16030@kadam>
 <5CD598C3.9090003@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CD598C3.9090003@bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9253 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=548
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905110067
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9253 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=595 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905110067
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

return -EINVAL; is more readable (100% unambiguous) than a break
statement.

ergards,
dan carpenter

